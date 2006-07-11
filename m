Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWGKRG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWGKRG2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWGKRG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:06:28 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:44705 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751101AbWGKRG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:06:27 -0400
Message-ID: <44B3DA77.50103@garzik.org>
Date: Tue, 11 Jul 2006 13:05:59 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: "H. Peter Anvin" <hpa@zytor.com>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru> <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com> <20060711164040.GA16327@suse.de>
In-Reply-To: <20060711164040.GA16327@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
>  On Tue, Jul 11, H. Peter Anvin wrote:
> 
>> When you say "loop mount code" I presume you mean legacy initrd support 
>> (which doesn't use loop mounting.)  Legacy initrd support is provided to 
>> be as compatible as possible, obviously.
> 
> Yes.
> To create the initrd you needed a loop file, at least for ext2, minix etc.
> 
> But so far, the arguments are not convincing that kinit has to be in the
> kernel tree.

Two are IMO fairly plain:

* Makes sure you can boot the kernel you just built.

* Makes it easier to move stuff between kernel and userspace.


