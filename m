Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289458AbSAKTmj>; Fri, 11 Jan 2002 14:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289008AbSAKTm3>; Fri, 11 Jan 2002 14:42:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31240 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289458AbSAKTmT>; Fri, 11 Jan 2002 14:42:19 -0500
Subject: Re: compaq presario 706 EA via 686a sound card
To: raul@dif.um.es (Raul Sanchez Sanchez)
Date: Fri, 11 Jan 2002 19:54:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1010777501.791.2.camel@raul> from "Raul Sanchez Sanchez" at Jan 11, 2002 08:31:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16P7kZ-0000A0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can hear the sound only with the higest volume in the mixer and my ear
> put in the speaker. It's so much :(
> 
> Perhaps the problem isn't the soundcard because the computer have a
> hardware sound volume controler, but i'm not sure. does anybody know
> where is the problem and how can i solve it?

Its common for laptops to have some kind of amplifier control (to powersave
better). Firstly does the problem show up with ACPI not compiled into the
system ?

If it still shows up then I guess you want to try flipping the EAPD bit
on the AC97 codec and hoping that the amp was wired conventionally
