Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264627AbUDVSnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264627AbUDVSnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 14:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbUDVSnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 14:43:22 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:56838 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264627AbUDVSnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 14:43:20 -0400
Date: Thu, 22 Apr 2004 19:43:16 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Jakub Bogusz <qboosh@pld-linux.org>
cc: linux-kernel@vger.kernel.org, <linux-nvidia@lists.surfsouth.com>,
       <ajoshi@shell.unixbox.com>
Subject: Re: [PATCH 2.4, 2.6] rivafb 16bpp text background colour fix
In-Reply-To: <20040422164101.GA16878@gruby.cs.net.pl>
Message-ID: <Pine.LNX.4.44.0404221942430.24337-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I applied it to the newer Nvidia driver I have. I plan to o stream line in 
the next few weeks.


On Thu, 22 Apr 2004, Jakub Bogusz wrote:

> I sent it already to Ani Joshi long time ago (December 2002),
> but it seems to be lost somewhere in time.
> I noticed that Pawel Goleniowski made the same patch and sent to LKML
> in December 2003 and January 2004:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0312.2/1258.html
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0401.1/0225.html
> but it's still not fixed.
> 
> The same applies to 2.6.x series, only filename
> (linux-2.6.*/drivers/video/riva/fbdev.c instead of .../riva/accel.c)
> and whitespace (tabs are used now instead of spaces) differ.
> 
> Original description (written in Dec 2002):
> > I noticed, that text background in 16bpp (only) modes is displayed
> > incorrectly. That's because convert_bgcolor_16() converts value to RGBA
> > from 15bpp, not 16bpp.
> >
> > The fix is attached (works for me, tested by one more person).
> > Patch was made against Linux 2.4.19, but should apply to 2.4.20 and
> > 2.5.x without changes.
> 
> 
> 

