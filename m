Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbUAJC2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 21:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUAJC2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 21:28:36 -0500
Received: from smtp2.dei.uc.pt ([193.137.203.229]:6873 "EHLO smtp2.dei.uc.pt")
	by vger.kernel.org with ESMTP id S264830AbUAJC2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 21:28:31 -0500
Date: Sat, 10 Jan 2004 02:28:17 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Jon Westgate <oryn@oryn.fsck.tv>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.1 synaptics problems tapping and tap'n'drag
In-Reply-To: <3FFF337E.3040603@oryn.fsck.tv>
Message-ID: <Pine.LNX.4.58.0401100226370.11211@student.dei.uc.pt>
References: <3FFF337E.3040603@oryn.fsck.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Sorry, in the previously e-mail I was wrong:

You have to pass to the kernel:

"psmouse_proto=imps" or "psmouse.psmouse_proto=imps", depending on if you have
the psmouse support as module or built-in in the kernel.

Hoping that helps,
Mind Booster Noori

- --
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================

On Fri, 9 Jan 2004, Jon Westgate wrote:

> Hi,
> I'm not sure if this is the right place to ask but if I run 2.6.1
> I get mouse problems that I didn't get with 2.6.0
> I'm running a compaq m300 (600MHz PIII) with a synaptics touch pad.
>
> In 2.6.0 there was an option to include or not include support for the
> synaptics touchpad (I found that my touchpad worked just fine with that
> option unchecked) in 2.6.1 that option is nolonger there.
>
> In 2.6.1 I find that the operation of the mouse is very erratic its
> almost impossible to take your finger off the pad without the cursor
> moving, Tapping doesn't work, The pad seems very accelerated (ie you
> drag your finger a short distance and the cursor is at the other side of
> the screen before you know it), Lastly if you dragged your finger to the
> edge of the pad it used to continue on smoothly. This no longer works.
>
> My question is:
> Is there a command line or append option I can put in lilo.conf to
> prevent the synaptics driver from trying to reprogram my touchpad? I
> quite like its default behavior. There is definatly something trying to
> reprogram it as I have to turn off my laptop for it's behavior to return
> to normal. Even if I reset it still needs a power cycle to fix it.
> dmesg says my touchpad is this:
> input: PS/2 Synaptics TouchPad on isa0060/serio4
>
> I'm not running any special drivers or settings in XF86Config
> I just have /dev/input/mice setup with protocol set as ImPS/2
>
> Regards
> Jon Westgate
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQE//2NDmNlq8m+oD34RAiSBAJ44eUWjfj7LsNZug0Aq3fzG8ByWvgCgzHjb
lWcACbs5tmGeIPGv80k1bjc=
=lewM
-----END PGP SIGNATURE-----

