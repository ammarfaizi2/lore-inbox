Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267638AbTALXkV>; Sun, 12 Jan 2003 18:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267653AbTALXkU>; Sun, 12 Jan 2003 18:40:20 -0500
Received: from 5-116.ctame701-1.telepar.net.br ([200.193.163.116]:46760 "EHLO
	5-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267638AbTALXkT>; Sun, 12 Jan 2003 18:40:19 -0500
Date: Sun, 12 Jan 2003 21:48:55 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Rob Wilkens <robw@optonline.net>
cc: Aaron Lehmann <aaronl@vitelus.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <1042410897.1209.165.camel@RobsPC.RobertWilkens.com>
Message-ID: <Pine.LNX.4.50L.0301122144380.26759-100000@imladris.surriel.com>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
 <1042400094.1208.26.camel@RobsPC.RobertWilkens.com> <20030112211530.GP27709@mea-ext.zmailer.org>
 <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
 <Pine.LNX.4.50L.0301121939170.26759-100000@imladris.surriel.com>
 <1042407845.3162.131.camel@RobsPC.RobertWilkens.com> <20030112214937.GM31238@vitelus.com>
 <1042409239.3162.136.camel@RobsPC.RobertWilkens.com> <20030112221802.GN31238@vitelus.com>
 <1042410897.1209.165.camel@RobsPC.RobertWilkens.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2003, Rob Wilkens wrote:

> ... jump over the "goto" statement.

Umm, an if + goto IS a conditional jump.  A modern compiler
will simply turn the goto into a conditional jump, meaning
that the normal code path doesn't do any jumps.

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
