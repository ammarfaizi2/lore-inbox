Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbREaXE6>; Thu, 31 May 2001 19:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263269AbREaXEs>; Thu, 31 May 2001 19:04:48 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:37135 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263281AbREaXEg>; Thu, 31 May 2001 19:04:36 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: your mail
Date: 31 May 2001 16:04:04 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9f6il4$ts6$1@cesium.transmeta.com>
In-Reply-To: <OFCA65A58C.155A1FB1-ON88256A5D.005BDA7A@tais.net> <200105312037.WAA01610@kufel.dom>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200105312037.WAA01610@kufel.dom>
By author:    Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
In newsgroup: linux.dev.kernel
> 
> BTW, linux-kernel readers: anybody is a volunteer for making the kernel size
> counter 32-bit here? This would enable using the simple bootloader for
> greater kernel loading...  (current limit is sligtly below 1MB)
> Possibly some 16/32-bit real mode code mixing would be necessary.
> 

PLEASE don't go there.  bootsect.S is fundamentally broken these days
(doesn't work on USB floppies, for example.)  It should be killed
DEAD, DEAD, DEAD and not dragged along like a dead albatross.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
