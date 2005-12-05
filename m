Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbVLENTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVLENTI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 08:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVLENTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 08:19:08 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:2438 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932416AbVLENTH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 08:19:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=r+YHNXbYbpcTltbtkUBx++jDKlDHaGHiru1m4rOWdiYqxsEk/JD0EeVeyzsPdid++bUnMRv3s0wJWnO/y90Nm6bgb7ltriXKlI05Q7qNYHQrQo/ejoDTZwDR4ODmP6JYxX0o82HJ/2vqE3PiLU0prWSu2A/54y2BKP541Gas00Q=
Message-ID: <4413284c0512050519n67c50a88t@mail.gmail.com>
Date: Mon, 5 Dec 2005 11:19:05 -0200
From: =?ISO-8859-1?Q?Herv=E9_Fache?= <herve.fache@gmail.com>
Reply-To: herve@lucidia.net
To: linux-kernel@vger.kernel.org
Subject: Scanner/webcam not working when connected to USB hub
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello guys,

I have the following problem: if connected directly to my computer's
USB ports, my webcam works correctly, but when connected through my
'AirVast' hub (124a:168b), it fails. The device is reported by lsusb
(IDs correct), but it does not work. The worst is: I have tried using
some proprietary OS, and it all worked there.

There are two possibilities (did I miss one?) I guess: either libusb
is playing, or the kernel USB stack is.

Now, rather than giving work to others, I don't mind trying to find
the problem myself, but I would appreciate a pointer to how to debug
such a problem... Tools? Compilation options?

Cheers,
Hervé.

Kernel: 2.6.12 from Kubuntu

Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             3
  wHubCharacteristic 0x0002
    No power switching (usb 1.0)
    Ganged overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0xf0
  PortPwrCtrlMask    0x37
 Hub Port Status:
   Port 1: 0000.0103 power enable connect
   Port 2: 0000.0100 power
   Port 3: 0000.0103 power enable connect
