Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265529AbUAIDnX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 22:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265564AbUAIDnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 22:43:22 -0500
Received: from [193.138.115.2] ([193.138.115.2]:46856 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265529AbUAIDnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 22:43:17 -0500
Date: Fri, 9 Jan 2004 04:40:21 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Valdis.Kletnieks@vt.edu
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity
 checking 
In-Reply-To: <200401090336.i093aBxB004312@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.56.0401090437060.11276@jju_lnx.backbone.dif.dk>
References: <200401090336.i093aBxB004312@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Jan 2004 Valdis.Kletnieks@vt.edu wrote:

> On Thu, 08 Jan 2004 19:20:21 PST, Andrew Morton said:
> > I've always had little confidence in the elf loader.  The problem is
> > complex, the code quality is not high and the consequences of an error
> are
> > severe.
>
> You might want to read this very interesting dissection of the ELF
> format
> for fun and non-profit.
>
> http://www.muppetlabs.com/~breadbox/software/tiny/teensy.html
>
> All I can say is - although it's insanely creative, this is *NOT* how I
> want my ELF loader to work. ;)
>
I know of the document, but thank you for pointing it out, it's quite an
interresting read. Actually, reading that exact document ages ago was what
initially caused me to start reading the ELF loading code (thinking
"there's got to be something wrong here").
I've actually been planning to use some of the crazy stunts he pulls
with that code as validity checks of the code I want to implement (in
adition to specially tailored test-cases ofcourse).


-- Jesper Juhl


