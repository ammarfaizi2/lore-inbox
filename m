Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291898AbSBTPAY>; Wed, 20 Feb 2002 10:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291890AbSBTPAO>; Wed, 20 Feb 2002 10:00:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6409 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291893AbSBTO75>; Wed, 20 Feb 2002 09:59:57 -0500
Subject: Re: SC1200 support?
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Wed, 20 Feb 2002 15:14:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0202201423001.22702-100000@mustard.heime.net> from "Roy Sigurd Karlsbakk" at Feb 20, 2002 02:32:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dYRh-0003nu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have this set-top box with a National Semiconductor Geode SC1200 chip
> with a built-in watch-dog plus a lot more.

It depends what BIOS firmware you have

> Does anyone know if there is any support for the sc1200-specific features
> in the current kernels, or if there are patches available?

Most Cyrix MediaGX / NatSemi Geode stuff seems to work. Its all a bit
complicated because most of the hardware is a BIOS manufactured illusion
using SMM mode. On the CS5530/5530x at least we support VSA1 video, audio
(including the needed bug workarounds) etc. Not afaik the watchdog. 
Watchdog drivers are easy to right fortunately.

If you have VSA2 based firmware then I've no idea what you'll get

Alan
