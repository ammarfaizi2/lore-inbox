Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130217AbRBMFKr>; Tue, 13 Feb 2001 00:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130313AbRBMFKi>; Tue, 13 Feb 2001 00:10:38 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:6024 "EHLO zooty.lancs.ac.uk")
	by vger.kernel.org with ESMTP id <S130217AbRBMFK2>;
	Tue, 13 Feb 2001 00:10:28 -0500
Message-Id: <l03130323b6ae7005d490@[192.168.239.101]>
In-Reply-To: <3A88AE26.BA69E57A@cdi.com>
In-Reply-To: <20010201183231.A373@tuxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 13 Feb 2001 05:10:16 +0000
To: linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [ANNOUNCE] Animated framebuffer logo for 2.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've seen in recently purchased computers that the very initial
>messages, like memory test, are masked by some kind of picture or logo
>(example are the HP kayaks). They display a message saying that pressing
>ESC or some function key displays the messages. Why not having the same
>in this pretty boot option. I wouldn't mind not seeing all those
>messages.

Not good enough in isolation.  Suppose the kernel freezes at a very early
stage, such as while detecting the CPU(s) or PCI bridge - are your geeky
reaction times fast enough to dismiss the logo in time to see the relevant
messages?  I agree with others that this should be a boot option - and not
one that needs said option to switch it off (though there should be one).

Eg: in lilo.conf use append = "bootlogo" to turn the logo on (it should
always be off by default, but can be turned on by distro makers or
end-users) - but then if you type "linux nologo" at the LILO prompt, the
"nologo" should over-ride the "bootlogo" so there's always a way to see all
the messages.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
