Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbULAMob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbULAMob (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 07:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbULAMob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 07:44:31 -0500
Received: from outmx019.isp.belgacom.be ([195.238.2.200]:34764 "EHLO
	outmx019.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261383AbULAMoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 07:44:25 -0500
Subject: module touchkitusb
From: Steven Van Loo <van.loo.steven@skynet.be>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1101905047.5115.16.camel@gremlin.g-sis.be>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Dec 2004 13:44:12 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have bought myself a Xenarc 700TS touchscreen that I want to use in
Linux. More specific a Debian Sarge distribution with a kernel 2.6.9.

After messing arround with the utilities provided with the screen, I
gave up as I could not get the tkusb.o module compiled. I am a newbie in
this building of modules. I have already modified the scripts to not use
rpm (as I am debian user) and thus continueing to build, but even when I
don't get errors anymore the module is not build...

Then I found that the 2.6.9 kernel has got a module for this screen
which is called touchkitusb. I compiled it in as a module when compiling
the 2.6.9 kernel and it succesfully finds the screen as eGalax inc
touchscreen. So I then have following modules loaded:
touchkitusb
mousedev
joydev	(don't think this is necessary)

Now when I use X, the touschreen works, but the touch-area is not equal
to the mouse movement on the screen. I have a 800x600 resolution
configured and I only need to touch the screen at something like 640x480
around the center of the screen to cover the whole screen.

I have googled around for more information on how to use this module,
but without any usefull information. I then tried to use this module
with the tkpaneld from the original driver, but this does not recognise
the screen. Also running touchcfg does not provide help.

It is now working via the /dev/input/mice or /dev/psaux device, so with
the help of mousedev. I tried the calibration function delivered with
it, but I get back "no response" message. So I assume I have to do it
differently.

There is no hardware problem with the screen as it works OK under Win*.

I hope somebody can help me point out how this module can be used ??? I
mean when you use the module, how do you then setup X to use it and what
do you need to have the correct "touch area". I also already tried
different values like MinimumXPosition but this does not change anything
to the problem I have. It looks to me a simple problem, but I have
already search several days/weeks without finding it.


THANKS to help me out!
Steven.

