Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264714AbRFVKte>; Fri, 22 Jun 2001 06:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265210AbRFVKtZ>; Fri, 22 Jun 2001 06:49:25 -0400
Received: from network.admin.crestech.ca ([132.251.1.3]:44551 "EHLO
	mailhub.CRESTech.ca") by vger.kernel.org with ESMTP
	id <S264714AbRFVKtP>; Fri, 22 Jun 2001 06:49:15 -0400
Date: Fri, 22 Jun 2001 06:49:11 -0400 (EDT)
From: Kipp Cannon <kipp@sgl.crestech.ca>
To: kernel-list <linux-kernel@vger.kernel.org>
Subject: Q: /proc/driver file philosophy
Message-ID: <Pine.GSO.4.05.10106220619290.19756-100000@s3.sgl.crestech.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm maintaining a device driver that has recently had the ability to
control multiple units added to it.  At present, applications can get info
on the driver's and hardware's status through a file in /proc/driver.  
What I would like to know is what the prefered way to handle multiple
devices is:  multiple files in /proc/driver or one file with multiple
sections in it?

As the developer of the driver's associated user space utilities I think
my preference is for multiple files because that keeps those apps as
simple as possible.  As the developer of the driver, however, having a
single /proc file and a loop is the simplest solution.  So is there an
(un)official position on this sort of thing or should I flip a coin?

							-Kipp

