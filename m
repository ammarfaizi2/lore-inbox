Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281587AbRKRXCD>; Sun, 18 Nov 2001 18:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281624AbRKRXBx>; Sun, 18 Nov 2001 18:01:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51464 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281589AbRKRXBg>; Sun, 18 Nov 2001 18:01:36 -0500
Subject: Re: Maestro 2E vs. Power mgmt
To: fauxpas@temp123.org (Faux Pas III)
Date: Sun, 18 Nov 2001 23:09:12 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011118175553.A18245@temp123.org> from "Faux Pas III" at Nov 18, 2001 05:55:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E165b3o-0004es-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another interesting finding here... whenever something else is
> generating a lot of interrupts (specifically, those devices that
> share IRQ 11 with the sound card), the sound actually comes out
> correctly, or at least more correctly... still slow.

Intriguing - so its as if the sound driver isnt generating interrupts
(one way to test that would be to monitor /proc/interrupts both with power
on mains and off of mains)
