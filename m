Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272129AbTG2V1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272221AbTG2VYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:24:09 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:46855 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272129AbTG2VWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:22:10 -0400
Date: Tue, 29 Jul 2003 22:22:07 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Jan Huijsmans <huysmans@xs4all.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test 2 & matroxfb or orinoco wifi card
In-Reply-To: <XFMail.20030729223514.huysmans@xs4all.nl>
Message-ID: <Pine.LNX.4.44.0307292221130.5874-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> After digging a bit in the archives I couldn't find the solution to my problem,
> so I'm asking you guys.
> 
> I found the "matroxfb and 2.6.0-test2" thread, so it's possible to compile the
> kernel with the matrox framebuffer, but I can't find what I'm missing. Did I
> forget to set a config option (all copied from the 2.4.21 config except the
> nForce2 agp chipset)?
> 
> This is the error I'm getting while linking. 
> 
> drivers/built-in.o(.text+0x89c80): In function `matroxfb_set_par':
> : undefined reference to `default_grn'
> drivers/built-in.o(.text+0x89c85): In function `matroxfb_set_par':
> : undefined reference to `default_blu'
> drivers/built-in.o(.text+0x89c93): In function `matroxfb_set_par':
> : undefined reference to `color_table'
> drivers/built-in.o(.text+0x89c9b): In function `matroxfb_set_par':
> : undefined reference to `default_red'

Ug. There is a patch for that but it never got included. BTW this means 
you didn't turn on Framebuffer console. Please turn it on.


