Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWB1Con@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWB1Con (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 21:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWB1Con
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 21:44:43 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:16543 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932080AbWB1Com (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 21:44:42 -0500
Subject: Line6 variax driver
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: grabner@icg.tu-graz.ac.at
Content-Type: text/plain
Date: Mon, 27 Feb 2006 21:24:30 -0500
Message-Id: <1141093470.3264.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an excerpt from Markus's mail to alsa-devel.  We are trying to
get his out of tree Line6 driver into the kernel.  The PCM and MIDI
stuff goes in ALSA, but can someone recommend the most appropriate type
of driver for the Variax component of his Line6 driver - basically just
a /sys interface to the pickup settings on these guitars?

Thanks,

Lee

    I just had a brief conversation with Lee Revell about the question if a 
USB driver for Line6 guitar equipment I am working on since 2004 (see 
http://www.tanzband-scream.at/line6) could be included in ALSA. In 
particular, the following devices are supported:
*) POD series (http://www.line6.com/products/pods): these devices digitally 
simulate the sound of different guitar amplifiers. The user can control these 
devices by several dials without connecting them to the PC, or by appropriate 
software running on a PC to which the device is connected via USB. Moreover, 
the guitar signal can be captured, and simultaneously a PCM signal from the 
PC can be played back (full-duplex).
*) Variax guitars (http://www.line6.com/variax) connected to the PC via an USB 
interface (http://www.line6.com/variaxWorkbench): these guitars digitally 
simulate the sound of different guitars. The model parameters (e.g., pickup 
type and position) can be modified via USB (the current version of the Linux 
driver can only read these parameters, however).


