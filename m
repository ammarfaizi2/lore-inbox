Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTKTSsw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 13:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbTKTSsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 13:48:51 -0500
Received: from N055P025.adsl.highway.telekom.at ([213.33.6.217]:54670 "EHLO
	server.lan") by vger.kernel.org with ESMTP id S262914AbTKTSsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 13:48:50 -0500
From: Melchior FRANZ <mfranz@aon.at>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 sidewinder joystick
Date: Thu, 20 Nov 2003 19:48:38 +0100
User-Agent: KMail/1.5.93
X-PGP: http://members.aon.at/mfranz/melchior.franz
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311201948.38381@pflug2.gphy.univie.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Scott Robinson -- Thursday 20 November 2003 19:30:
> This is a repeat bug report - originally to the input subsystem mailing
> list and the module maintainer. I received no response and no indication
> there was reception.

I reported a similar bug twice on the JS list and got no reply.
The drivers for analog joysticks are f*cked up in the 2.6.0 series,
and the maintainers don't care. I've given up and bought a USB
joystick.

 

[...]
> Nov 20 10:26:04 tara kernel: gameport: pci0000:01:07.1 speed 828 kHz
> Nov 20 10:26:06 tara kernel: input: Analog 2-axis 4-button joystick at
> pci0000:01:07.1/gameport0 [TSC timer, 1446 MHz clock, 1250 ns res]

I didn't have your device node problems, but the analog driver
didn't recognize the hat switch any more. It was a Saitek X8-30
"Analog 3-axis 4-button 1-hat CHF joystick" that worked flawlessly
before (with kernels 2.4.*). Eventually a timing problem. There
weren't much changes in the analog/ns558 modules during 2.5.
Tried to fix it, to no avail.

m.
