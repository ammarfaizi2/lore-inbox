Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314351AbSD0ScS>; Sat, 27 Apr 2002 14:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314352AbSD0ScR>; Sat, 27 Apr 2002 14:32:17 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60433 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314351AbSD0ScQ>; Sat, 27 Apr 2002 14:32:16 -0400
Subject: Re: [PATCH] 2.4.18 - CMI9738 codec support in ac97_codec.c
To: eclark@ee.tcd.ie
Date: Sat, 27 Apr 2002 19:50:45 +0100 (BST)
Cc: ollie@sis.com.tw, linux-kernel@vger.kernel.org
In-Reply-To: <20020427044051.SM00304@moog.mee.tcd.ie> from "Ed  Clark" at Apr 27, 2002 05:01:55 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E171XHR-0000IF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<original deleted - your mailer needs debugging so it wordwraps text/plain
 as per the RFC's>

I'd rather keep the core AC97 code clean. It would be much nicer to have
the driver handle this case, since for a partially implemented codec only
the card driver really knows the right strategy.
