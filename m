Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTFLMQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 08:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbTFLMQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 08:16:28 -0400
Received: from inconnu.isu.edu ([134.50.8.55]:37789 "EHLO inconnu.isu.edu")
	by vger.kernel.org with ESMTP id S264479AbTFLMQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 08:16:27 -0400
Date: Thu, 12 Jun 2003 06:30:06 -0600 (MDT)
From: I Am Falling I Am Fading <skuld@anime.net>
X-X-Sender: skuld@inconnu.isu.edu
To: Gregor Essers <gregor.essers@web.de>
cc: davej@codemonkey.org.uk, <linux-kernel@vger.kernel.org>
Subject: Re: Via KT400 and AGP 8x Support
In-Reply-To: <000f01c33013$c713eeb0$6602a8c0@Schleppi>
Message-ID: <Pine.LNX.4.44.0306120626540.14123-100000@inconnu.isu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jun 2003, Gregor Essers wrote:

> Hi i will look into that with the bridges, i hope that Hercules is so that
> they give me the spec´s (Plan of the Card) with the Jupers/Bridges for AGP
> 2.0.

Follow the traces from pins A3 and A11 on the edge connector, they'll lead
you to the 0 ohm resistor jumpers (Just look for the little rectangular
things that have a 0 printed on them where others have numbers).

Make sure they are the ones for A3 and A11, and remove 'em. Voila, an AGP 
2.0 card.

(These are on the ATI 9700 reference design, which all manufacturers have 
copied so far, your Hercules will probably have them too, although it's 
a 9800 I'm assuming)

> It´s very SAD that Ati and Nvidia will not give the Specs or an Sourcecode
> of the Drivers :/.

Agreed. :-(

-----
James Sellman -- ISU CoE-CS/ISLUG Linux Lab Admin   |"Lum, did you just see
----------------------------------------------------| a hentai rabbit flying
skuld@inconnu.isu.edu      |   // A4000/604e/60 128M| through the air?"
skuld@anime.net            | \X/  A500/20 3M        |   - Miyake Shinobu

