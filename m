Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280002AbRLBPbJ>; Sun, 2 Dec 2001 10:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280056AbRLBPa7>; Sun, 2 Dec 2001 10:30:59 -0500
Received: from mout1.freenet.de ([194.97.50.132]:26318 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S280002AbRLBPaw>;
	Sun, 2 Dec 2001 10:30:52 -0500
Message-ID: <3C0A4986.8020708@athlon.maya.org>
Date: Sun, 02 Dec 2001 16:32:22 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: IBM Thinkpad T21: Hotplugging of cdrom and floppy devices
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm using actual 2.4.x-kernels with the laptop I mentioned in the subject.

When I put off my floppy-device (/dev/fd1) and put in my cdrom-device 
(/dev/hdc; both no pcmcia-devices) or vice versa, the kernel doesn't 
recognize this change. The change - LED of the laptop is blinking until 
I suspend the laptop for example with apm -s or with the keyboard Fn-F4 
and rewake it. After this "little sleep", the kernel suddenly knows 
about the new hardware and it can handle it.

I tested the hotplugging-feature of the kernel 2.4.x - but I couldn't 
get it working.

Is there any other possibility to give the kernel a chance to detect a 
hardware change without going through the suspend-mode? I mean, is there 
a piece of software, which does the same as in the wake-up-situation of 
the notebook after suspend?

Thank you for your advice,
Andreas Hartmann

