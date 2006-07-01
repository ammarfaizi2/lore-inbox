Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751635AbWGAPsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbWGAPsI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbWGAPsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:48:07 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:4828 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751635AbWGAPsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 11:48:06 -0400
Message-ID: <44A6991B.9000907@garzik.org>
Date: Sat, 01 Jul 2006 11:47:39 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jeff Bailey <jbailey@ubuntu.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060630181131.GA1709@elf.ucw.cz> <44A5AE17.4080106@tls.msk.ru> <44A5B07E.9040007@zytor.com> <1151751417.2553.8.camel@localhost.localdomain>
In-Reply-To: <1151751417.2553.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Bailey wrote:
> The Ubuntu initramfs doesn't use kinit, and it would be nice if we
> weren't forced to.  We do a number of things in our initramfs (like a
> userspace bootsplace) which we need done before most of the things kinit
> wants to do take place.

You would be required to perform the same duties as kinit (is the list 
of steps documented?), but not strictly required to use hpa's 
incarnation of kinit+klibc.

	Jeff


