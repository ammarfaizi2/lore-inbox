Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVCVOFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVCVOFb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 09:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVCVOFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 09:05:31 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:20192 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261257AbVCVOFO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 09:05:14 -0500
Date: Tue, 22 Mar 2005 15:05:14 +0100
From: DervishD <lkml@dervishd.net>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Voodoo 3 2000 framebuffer problem
Message-ID: <20050322140514.GB9073@DervishD>
Mail-Followup-To: Bodo Eggert <7eggert@gmx.de>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <fa.cmkmtid.l6sdqh@ifi.uio.no> <E1DDjsg-0000rS-0e@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1DDjsg-0000rS-0e@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Bodo :)

 * Bodo Eggert <7eggert@gmx.de> dixit:
> >     Linux Kernel 2.4.29, in a do-it-yourself linux box, equipped with
> > an AGP Voodoo 3 2000 card, tdfx framebuffer support. I boot in vga
> > mode 0x0f05, with parameter 'video=tdfx:800x600-32@100' and I get
> > (correctly) 100x37 character grid. All of that is correct. What is
> > not correct is the characters attributes, namely the 'blink'
> > attribute.
> Blinking a whole screen of text is much more expensive than a block cursor.

    I don't want to blink a whole screen of text... But I think I
know what you mean, for blinking some text on the screen you need to
be able to blink the entire screen.

> You'll want hardware support, e.g. some kind of double-buffering or
> using 240 colors just for that purpose in a 256 color mode. (I
> would not implement that.)

    I assumed that the textmodes of framebuffer supported all
capabilities that the standard text modes support... So, no blinking
text in framebuffer, am I wrong?

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
