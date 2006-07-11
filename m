Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWGKRQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWGKRQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWGKRQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:16:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:57798 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751133AbWGKRQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:16:26 -0400
Date: Tue, 11 Jul 2006 19:16:24 +0200
From: Olaf Hering <olh@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060711171624.GA16554@suse.de>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru> <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com> <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44B3DA77.50103@garzik.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jul 11, Jeff Garzik wrote:

> Two are IMO fairly plain:
> 
> * Makes sure you can boot the kernel you just built.

There is always some sort of prereq when new features get added.
Documentation/Changes has a long list. Some setup need more updates,
some need fewer updates. No idea what your experience is.
Old klibc was trivial to build (modulo that kernel header mess), and I
expect that kinit handles old kernels.

> * Makes it easier to move stuff between kernel and userspace.

What do you have in mind here?
Once prepare_namespace is gone, there is no userspace code left.
