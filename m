Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbUKXCeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbUKXCeZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 21:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUKXCeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 21:34:25 -0500
Received: from 65-75.sh.cgocable.ca ([205.151.65.75]:60394 "EHLO mail.pixel.ca")
	by vger.kernel.org with ESMTP id S261677AbUKXCeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 21:34:23 -0500
From: "Mario Gaucher" <zadiglist@zadig.ca>
To: linux-kernel@vger.kernel.org
Subject: framebuffer problem on a PowerMac 7300
Date: Tue, 23 Nov 2004 21:34:20 -0500
Message-Id: <20041124021824.M80598@zadig.ca>
X-Mailer: Open WebMail 2.41 20040926
X-OriginatingIP: 192.168.25.10 (zadig)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a PowerMac 7300
kernel 2.6.8 works fine on this computer
kernel 2.6.9 does not work

I have the same problem that John Mock has with his PowerMac 8500...
framebuffer does not work with 2.6.9 (everything is black with a few thin
diagonal lines of dots and dashes)... this is with the onboard video
(controlfb driver).
With a Matrox Millenium PCI card (matroxfb driver), I get something on the
screen but except for the little Tux in the corner, all characters on the
screen are corrupted... 

it works fine with 2.6.8 kernel with both drivers

I tried with 2.6.10-rc2-bk8 (that I got on kernel.org) and I have the same
problem...

Because frame buffer does not work, I can not boot this computer... it
does not respond to ping when I have this problem...

I did not try any pre-2.6.9 kernel, so I do not know where it stops to work.


I am not a programmer, so I can not offer any code to fix this problem...
but if can test some kernel patches to get this problem fixed, I will be
happy to do it.


sorry, I did not reply to the original message sent by John Mock, because
I was not subscribed to this mailing list when he sent his message...


- - - - - - - - - - - - - - - - - - - -
Excuse my bad english :-)
