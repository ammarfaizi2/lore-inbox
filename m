Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVBWNWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVBWNWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 08:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVBWNWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 08:22:39 -0500
Received: from viefep13-int.chello.at ([213.46.255.15]:54608 "EHLO
	viefep13-int.chello.at") by vger.kernel.org with ESMTP
	id S261487AbVBWNWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 08:22:36 -0500
Message-ID: <421C83A2.9040502@vollwerbung.at>
Date: Wed, 23 Feb 2005 14:22:42 +0100
From: Nils Kalchhauser <n.kalchhauser@vollwerbung.at>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mouse still losing sync and thus jumping around
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


I still get the following messages and my mouse jumps around weirdly 
making work rather difficult regardless of which 2.6 kernel I use (tried 
2.6.8, 2.6.9, 2.6.10, 2.6.11-rc2 with patch-see below, 2.6.11-rc4):

psmouse.c: Mouse at isa0060/serio4/input0 lost synchronization, throwing 
2 bytes away.
psmouse.c: Mouse at isa0060/serio4/input0 lost synchronization, throwing 
2 bytes away.
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 4
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 - driver resynched.
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1

(using either the touchpad or the connected PS/2 mouse)

I tried the patch Dmitry Torokhov supplied in the message with subject 
"Re: Really annoying bug in the mouse driver" from Jan 27 which 
supposedly fixes this problem. unfortunately it only got worse.

the problem is really annoying with windows sometimes closing because of 
sporadic mouse clicks etc. I would happily try patches and help in 
debugging, so if anyone has an idea or if more info about my 
setup/config is needed, just tell me.


thanks a lot,
Nils

