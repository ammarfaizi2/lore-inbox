Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271763AbRH0Plb>; Mon, 27 Aug 2001 11:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271762AbRH0PlV>; Mon, 27 Aug 2001 11:41:21 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61958 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271758AbRH0PlJ>; Mon, 27 Aug 2001 11:41:09 -0400
Subject: Re: "Machine Exception Check.... " with the last kernel?
To: jfbeam@bluetopia.net (Ricky Beam)
Date: Mon, 27 Aug 2001 16:44:30 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        robert.casanova@grifols.com (Casanova Robert),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0108271133260.23852-100000@sweetums.bluetronic.net> from "Ricky Beam" at Aug 27, 2001 11:37:13 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15bOYw-000495-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Machine Check Exception is a trap the processor takes when it finds itself
> >internally inconsistent. Check the cooling, voltages and clock speeds are
> 
> Umm, that still doesn't address the question.  What good is it if there's
> nothing to decode the damned numbers? (and it's not documented at all.)

Pentium II, III and IV manuals from Intel document things in detail. The
brain dead folks at Intel never got around to releasing the pentium one
as far as I know but the data is stil useful for detecting failing boxes
and also for things like getting replacements

> >right. Its your CPU telling you it noticed things didnt seem happy.
> 
> ... Or a compaq laptop signalling APM events.  2.4.9 locks up within
> nanoseconds of beginning to activate MCE on my Compaq LTE5400 (P150.)
> I have to turn it off to get the machine to boot ("nomce")

Its your CPU telling you it noticed things didn't seem happy. If your
machine is so broken that the motherboard is asserting external errors on
power switching events its broken. Some compaq boxes are, thats why nomce
exists
