Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbUKEUko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbUKEUko (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 15:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbUKEUkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 15:40:43 -0500
Received: from main.gmane.org ([80.91.229.2]:46315 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261214AbUKEUkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 15:40:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alexander Fieroch <Fieroch@web.de>
Subject: kernel module grip with gravis Xterminator gamepad
Date: Fri, 05 Nov 2004 21:17:02 +0100
Message-ID: <cmgn3s$fb0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: osten.wh.uni-dortmund.de
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-de, en-us, en
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I've got the gravis Xterminator gamepad and I think, the driver grip has
to be adapted.
The gamepad works, but the order of its axes and buttons is not correct.
The gamepad has got a proportional directional pad (joystick-like
control) and a 8-way digital directional pad. There are other
proportional flippers and throttle buttons so that they are 9 axes all
together.

The jscalibrator detects axis 0 and axis 1 for the proportional
directional pad, then the other axes and at last the 8-way directional
pad as axis 7 and axis 8.
Because of the 8-way directional pad is the main directional pad and
many games only use axis 0 and axis 1 for control, this directional pad
should be axis 0 and axis 1. Axis 2 and axis 3 should be for the
proportional directional pad and then the other ones should follow.

It's the same with the buttons. Button 0 and button 1 are on
the bottom side and hard to reach. Button 0 - 5 should be the six main
buttons.

Is it possible to change this or is there any possibility for me as user
to change the order of the axes and button ids?

Thanks in advance,
Alexander

PS: I'm running kernel 2.6.9 with module grip for the gamepad
Xterminator (gameport, not usb)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBi9++lLqZutoTiOMRAnmVAJ9vtcuj/fbvgPd56j7xVF3rVFnprgCfThXn
63lsUaJfAxCvCh/TV1VQul8=
=+cg9
-----END PGP SIGNATURE-----

