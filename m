Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbREaWBl>; Thu, 31 May 2001 18:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263251AbREaWBc>; Thu, 31 May 2001 18:01:32 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:17680 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S263246AbREaWBT>; Thu, 31 May 2001 18:01:19 -0400
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200105312037.WAA01610@kufel.dom>
Subject: Re: your mail
To: kufel!tais.toshiba.com!Ramil.Santamaria@green.mif.pg.gda.pl
Date: Thu, 31 May 2001 22:37:54 +0200 (CEST)
Cc: kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl
In-Reply-To: <OFCA65A58C.155A1FB1-ON88256A5D.005BDA7A@tais.net> from "Ramil.Santamaria@tais.toshiba.com" at May 31, 2001 09:53:43 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Minor issue with bootsect.s.

1. bootsect.S is the source file

> The single instance of the lds assembly instruction includes the comment of
> !  ds:si is source
> ...
> seg fs
> lds  si,(bx)        !     ds:si is source
> ...
> Is this comment not in reverse order (i.e should be lds
> dest,src)................

2. This is not a comment of i386 mnemonics. This comments the role of
   specific register in the following instructions.

BTW, linux-kernel readers: anybody is a volunteer for making the kernel size
counter 32-bit here? This would enable using the simple bootloader for
greater kernel loading...  (current limit is sligtly below 1MB)
Possibly some 16/32-bit real mode code mixing would be necessary.

Andrzej
