Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbVKLVA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVKLVA2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbVKLVA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:00:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8117 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964806AbVKLVA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:00:27 -0500
Date: Sat, 12 Nov 2005 13:00:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Michael Buesch <mbuesch@freenet.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
cc: linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linuv 2.6.15-rc1
In-Reply-To: <200511122145.38409.mbuesch@freenet.de>
Message-ID: <Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
 <200511122145.38409.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 12 Nov 2005, Michael Buesch wrote:
> 
> Latest GIT tree does not boot on my G4 PowerBook.

What happens if you do

	make ARCH=powerpc

and build everything that way (including the "config" phase)?

So far ppc32 is still a valid architecture, and your config file makes it 
clear that you've used that. But I suspect most of the active testing has 
been done with the "powerpc" architecture compiled for 32-bit.

That said, the ppc32 tree should still work. BenH? Paul?

		Linus
