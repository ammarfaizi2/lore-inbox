Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWGKQkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWGKQkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWGKQkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:40:43 -0400
Received: from cantor.suse.de ([195.135.220.2]:35731 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751035AbWGKQkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:40:42 -0400
Date: Tue, 11 Jul 2006 18:40:40 +0200
From: Olaf Hering <olh@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Roman Zippel <zippel@linux-m68k.org>,
       torvalds@osdl.org, klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060711164040.GA16327@suse.de>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru> <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44B3D0A0.7030409@zytor.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jul 11, H. Peter Anvin wrote:

> When you say "loop mount code" I presume you mean legacy initrd support 
> (which doesn't use loop mounting.)  Legacy initrd support is provided to 
> be as compatible as possible, obviously.

Yes.
To create the initrd you needed a loop file, at least for ext2, minix etc.

But so far, the arguments are not convincing that kinit has to be in the
kernel tree.
