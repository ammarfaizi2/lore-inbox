Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263105AbUCSQqB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 11:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbUCSQqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 11:46:01 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:48512 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S263105AbUCSQp6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 11:45:58 -0500
Date: Fri, 19 Mar 2004 16:44:47 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: CDFS
In-Reply-To: <Pine.LNX.4.53.0403191127040.3230@chaos>
Message-ID: <Pine.LNX.4.44.0403191640460.3892-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Richard B. Johnson wrote:

> On Fri, 19 Mar 2004, Randy.Dunlap wrote:
> 
> > On Fri, 19 Mar 2004 11:01:44 -0500 (EST) Richard B. Johnson wrote:
> >
> > |
> > | Just got a CD/ROM that 'works' on W$, but not Linux.
> > | W$ `properties` call it 'CDFS'. Is there any such Linux
> > | support?
> >
> > You did try to search for it, right?
> >
> 
> Sure did and what I get was an explaination that, for
> Linux, the letters "CDFS" refer to something that "exports
> all the tracks and boot images of a CD as normal files".
> 
> That's not what I want. I want to mount a CDFS file-system.
> 
> Given that, maybe the explaination is bogus, but I
> need some CDFS file-system support so I can mount
> a Microsoft CDFS CD/ROM. If such support exists, I
> would think that I should be able to do:
> 
> mount -t cdfs /dev/cdrom /mnt

Unless something has changed seriously in just a few years, the name CDFS
was always just a Microsoft synonym for the proper name iso9660. The Linux
name CDFS is the filesystem which Randy pointed you at, for mounting
multi-session CDs and accessing individual sessions as files (iso images).

So, if you have what Microsoft calls CDFS then it is simply iso9660 and if 
it doesn't mount then either your CD is damaged (and you only get a false 
"impression" of it working in Windows) or there is a bug in Linux iso9660 
implementation. What are the error messages you get when you try to mount 
it as an iso9660?

(You didn't forget to compile Joliet and RR extensions into your kernel, 
did you?)

Kind regards
Tigran

