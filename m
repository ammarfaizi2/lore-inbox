Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264892AbTLFACp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 19:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbTLFACp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 19:02:45 -0500
Received: from gaia.cela.pl ([213.134.162.11]:55048 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S264892AbTLFACn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 19:02:43 -0500
Date: Sat, 6 Dec 2003 01:02:20 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Kendall Bennett <KendallB@scitechsoft.com>
cc: David Schwartz <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux GPL and binary module exception clause? 
In-Reply-To: <3FD06173.4829.4801EFD4@localhost>
Message-ID: <Pine.LNX.4.44.0312060100550.11626-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another point worth mentioning is that if the Linux kernel headers are 
> pure GPL, then user land programs that use the Linux kernel headers 
> themselves would also be pure GPL by extension if the above argument 
> holds water. Clearly the Linux developers would like to believe 

Problem being that user space programs are not supposed to use the kernel 
headers - they're supposed to use the glibc headers anyway.  In fact the 
latest kernel source headers don't work in userspace period.  And the user 
space glibc 'kernel' headers are released and distributed seperately and 
contain much less code than the actual kernel kernel headers.

Cheers,
MaZe.


