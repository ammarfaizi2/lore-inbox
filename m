Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWH1Lhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWH1Lhh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 07:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWH1Lhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 07:37:37 -0400
Received: from razorback.tcsn.co.za ([196.41.199.53]:24329 "EHLO tcsn.co.za")
	by vger.kernel.org with ESMTP id S964830AbWH1Lhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 07:37:37 -0400
Date: Mon, 28 Aug 2006 13:38:11 +0200
From: Henti Smith <henti@geekware.co.za>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux on Intel D915GOM oops
Message-ID: <20060828133811.5338a49b@yoda.foad.za.net>
In-Reply-To: <1156754346.3034.167.camel@laptopd505.fenrus.org>
References: <20060828102149.26b05e8b@yoda.foad.za.net>
	<1156754346.3034.167.camel@laptopd505.fenrus.org>
Organization: Geek Ware
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2006 10:39:06 +0200
Arjan van de Ven <arjan@infradead.org> wrote:

> this is the known bug where by default Linux uses the BIOS services
> for PCI rather than the native method.
> 
> try putting
> 
> pci=conf2
> 
> on the kerenl commandline
> 
> (and you may want to try a kernel newer than 2.6.8 btw)

Thanks Arjan, I can boot now .. tho everything else after that goes to
a ball of shit .. still trying to get it up and running for an install
hehe 

I had to use acpi=off as well ... this main-board doesn't seem to be
very stable ;P 

-- 
Henti Smith
henti@geekware.co.za
+27 82 958 2525
http://www.geekware.co.za

DISCLAIMER : 

Unauthorised use of characters, images, sounds, odors, severed limbs,
noodles, wierd dreams, strange looking fruit, oxygen, and certain parts
of Jupiter are strictly forbidden.  If I find you violating, or
molesting my property in any way, I will employ a pair of burly
convicts to find you, kidnap you, and perform god-awful sexual
experiments on you until you lose the ability to sound out vowels.  I
don't know why you are still reading this, but by doing so you have
proven that you have far too much time on your hands, and you should go
plant a tree, or read a book or something.
	- http://www.ctrlaltdel-online.com/
