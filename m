Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316050AbSETOMp>; Mon, 20 May 2002 10:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316051AbSETOMo>; Mon, 20 May 2002 10:12:44 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28422 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316050AbSETOMo>; Mon, 20 May 2002 10:12:44 -0400
Subject: Re: A cosmetic but useful change on soundcard.h
To: raul@pleyades.net
Date: Mon, 20 May 2002 15:32:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux-kernel)
In-Reply-To: <3CE8F933.mail58K110Q6B@viadomus.com> from "DervishD" at May 20, 2002 03:25:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E179oDU-0005jw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Would be possible (I can make the patch, is *very* easy) to pad
> *all* labels and names so all them are of the same size? Moreover,
> adding a #define with that size would help a lot user-space apps like
> mixers and the like. Simply using '80' as the size doesn't help, and
> I've seen a couple of mixer doing this...

I wouldnt worry about it - its best 2.4 keeps current behaviour. For 2.5
ALSA replaces OSS. If ALSA has the same stuff then fix ALSA
