Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268141AbUJGVLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268141AbUJGVLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267804AbUJGVIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:08:07 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:12722 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268155AbUJGUmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:42:00 -0400
Subject: Re: Maximum block dev size / filesystem size
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: aaron@alpete.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097180361.491.25.camel@main>
References: <1097180361.491.25.camel@main>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097177960.31547.132.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 07 Oct 2004 20:39:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-07 at 21:19, Aaron Peterson wrote:
> I work for a company with a 15 TB SAN.  All opinions about the
> disadvantages of creating really large filesystems aside, I'm trying to
> find out what is the maximum filesystem size we can allocate on our SAN
> that a linux box (x86) can really use.

For 2.4.x 1Tb (2Tb works for some devices but its a bit variable)

> What I can't seem to find anywhere is whether the 2 TB block device
> limit has improved/grown with 2.6 kernels (on x86 hardware).  Perhaps
> I've looked in the wrong places, but I haven't found anything.

2.6 fixed this problem although it appears not for some specialist
cases. Last time I checked LVM logical volumes over 2Tb were reported
problematic.

