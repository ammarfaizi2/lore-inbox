Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280945AbRKORS4>; Thu, 15 Nov 2001 12:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280949AbRKORSq>; Thu, 15 Nov 2001 12:18:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46349 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280945AbRKORSk>; Thu, 15 Nov 2001 12:18:40 -0500
Subject: Re: Maestro 2E vs. Power mgmt
To: fauxpas@temp123.org (Faux Pas III)
Date: Thu, 15 Nov 2001 17:26:01 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011115120314.A11264@temp123.org> from "Faux Pas III" at Nov 15, 2001 12:03:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E164QH3-0000xW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maestro 2E sound.  This works fine and dandy when on AC power, but
> when on battery, the sound doesn't play properly... xmms and 
> mpg123 show very slow (1/10 or so) progress through the file and
> the sound that results is a staticky approximation of the correct
> output.
> 
> I've tried with the power management both off and on, and with 
> apm off in the kernel altogether.  Tried kernels 2.4.{13,14,15-pre{2,3}}

Nothing immediately strikes me - could be its not got CLKRUN wired up
properly. What pci bridges does it have ?
