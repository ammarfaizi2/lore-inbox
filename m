Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264400AbTEZO53 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 10:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264403AbTEZO53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 10:57:29 -0400
Received: from lennier.cc.vt.edu ([198.82.162.213]:39184 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP id S264400AbTEZO52
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 10:57:28 -0400
Message-Id: <5.2.1.1.0.20030526110758.00a22930@pop.vt.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 26 May 2003 11:10:42 -0400
To: linux-kernel@vger.kernel.org
From: "John Anthony Kazos Jr." <jkazos@vt.edu>
Subject: Re: New make config options
In-Reply-To: <200305261004.25297.eric@cisu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>#DEFINE RANT 1
>
>Ok, I may not know what I'm talking about, or it may not actually be a good
>idea, but I had an ipifany about the configure scripts.
>
>         I spend most of my time in the configure script turning 
> everything into a
>module. (I play alot, and I like to have modules available to explore). There
>should a button or something where it will turn everything that CAN be
>compiled as a module, into  kernel modules. Then you can de-select a few
>things and compile the other few options that you need directly into the
>kernel.
>
>#IFDEF RANT
>It would save me alot of time knowing that all those stupid NIC cards are
>being compiled as modules when i'm not sure which one I have. I would rather
>have all the modules available in case  NIC breaks anyways.  I change NICS
>and i'm never sure what kind it is until it doesn't work and I need to
>compile ANOTHER module. I know some of them are obscure cards, but with all
>the options I can't really be sure if it's a card I might come across or not.
>I'd rather be safe and have a meg or two of NIC modules around then have to
>rebuild or compile a new modules when I find an exotic card.
>#ENDIF
>
>         Modules aren't used used until they're needed anyways so It 
> wouldn't cause
>conflicts or a big size differnece in the kernel (in my understanding). For
>us with fast machines(AMD XP1800+) it would just be an extra 5-7 minutes for
>the other modules to compile.
>
>Would anyone else be interested in this?

I would be heavily interested in this. Right now I have a hacked-together 
Debian box running my server and servers for others, and I'm trying to do a 
full system reconstruction on the side to swap out once (and hopefully only 
once). One key to this is to make an absolute minimal kernel and to have 
everything as modules, because even if I don't have the module I need, I 
can compile it and use it without having to restart the machine. Being able 
to have an automatic option which lets me 1) specify minimal options and 
have everything else as "no", then 2) takes every "no" which can be a 
module, and turns it to module, and 3) lets me go back in and turn off any 
particular modules I definately don't want, would be *marvelous*.

