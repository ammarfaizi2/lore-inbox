Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUAIXEh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 18:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbUAIXEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 18:04:37 -0500
Received: from painless.aaisp.net.uk ([217.169.20.17]:47261 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S263851AbUAIXEe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 18:04:34 -0500
Message-ID: <3FFF337E.3040603@oryn.fsck.tv>
Date: Fri, 09 Jan 2004 23:04:30 +0000
From: Jon Westgate <oryn@oryn.fsck.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.1 synaptics problems tapping and tap'n'drag
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm not sure if this is the right place to ask but if I run 2.6.1
I get mouse problems that I didn't get with 2.6.0
I'm running a compaq m300 (600MHz PIII) with a synaptics touch pad.

In 2.6.0 there was an option to include or not include support for the 
synaptics touchpad (I found that my touchpad worked just fine with that 
option unchecked) in 2.6.1 that option is nolonger there.

In 2.6.1 I find that the operation of the mouse is very erratic its 
almost impossible to take your finger off the pad without the cursor 
moving, Tapping doesn't work, The pad seems very accelerated (ie you 
drag your finger a short distance and the cursor is at the other side of 
the screen before you know it), Lastly if you dragged your finger to the 
edge of the pad it used to continue on smoothly. This no longer works.

My question is:
Is there a command line or append option I can put in lilo.conf to 
prevent the synaptics driver from trying to reprogram my touchpad? I 
quite like its default behavior. There is definatly something trying to 
reprogram it as I have to turn off my laptop for it's behavior to return 
to normal. Even if I reset it still needs a power cycle to fix it.
dmesg says my touchpad is this:
input: PS/2 Synaptics TouchPad on isa0060/serio4

I'm not running any special drivers or settings in XF86Config
I just have /dev/input/mice setup with protocol set as ImPS/2

Regards
Jon Westgate


