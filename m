Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263506AbTDPFLy (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 01:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264228AbTDPFLy 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 01:11:54 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:43022 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S263506AbTDPFLx (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 01:11:53 -0400
Message-Id: <200304160508.h3G58Qu13486@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Valdis.Kletnieks@vt.edu
Subject: Re: kernel support for non-English user messages
Date: Wed, 16 Apr 2003 08:03:20 +0300
X-Mailer: KMail [version 1.3.2]
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200304111823_MC3-1-3412-C273@compuserve.com> <200304141145.h3EBjku02917@Port.imtp.ilyichevsk.odessa.ua> <200304141423.h3EENeu8003539@turing-police.cc.vt.edu>
In-Reply-To: <200304141423.h3EENeu8003539@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 April 2003 17:23, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 14 Apr 2003 14:40:46 +0300, Denis Vlasenko said:
> > OTOH "I can go read the source" is the ultimate documentation
> > which we have for zero extra effort.
>
> It's a non-zero extra effort for me to poke around in the source for
> drivers/video/riva/fbdev.c trying to find what parameters are legal
> to attach to 'video=rivafb' - at least one posting to LKML has listed
> append="video=rivafb,xres:1024,yres:768,bpp:8" but looking at the
> rivafb_setup() code that only checks for "forceCRTC", "flatpanel",
> and "nomtrr" - so even MORE digging is needed to find out who parses
> the xres, yres, bpp values, what other values are legal, etc etc.

I talked about entirely different matter: what happens when you read
some doc and either it does not answer your question or is
demonstrably wrong? In Linux, you say "Linux sucks" and go read the code.
In Windows/Oracle/etc you say "Windows sucks" and start banging your
head against the wall.
--
vda
