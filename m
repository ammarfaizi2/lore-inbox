Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265310AbUAJTSV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265316AbUAJTSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:18:20 -0500
Received: from painless.aaisp.net.uk ([217.169.20.17]:51427 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S265310AbUAJTSQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:18:16 -0500
Message-ID: <40004FF7.6020507@oryn.fsck.tv>
Date: Sat, 10 Jan 2004 19:18:15 +0000
From: Jon Westgate <oryn@oryn.fsck.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.1 synaptics problems tapping and tap'n'drag
References: <3FFF337E.3040603@oryn.fsck.tv> <Pine.LNX.4.58.0401100226370.11211@student.dei.uc.pt>
In-Reply-To: <Pine.LNX.4.58.0401100226370.11211@student.dei.uc.pt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for that Marcos,
appending "psmouse.psmouse_proto=imps" in lilo.conf has returned my 
mouse to is usual self.
You are a star :)
I do seem to remember when I ran another well known os on this laptop 
that the mouse worked much better without the drivers installed.
I'm sure that the kernel driver probably works much better on new 
hardware and that some folk have put allot of hard work into the kernel 
and X driver. I think its very cool that with the X driver you can have 
non-linear settings left and right tappings as well as scroll bars etc. 
But I must be getting old because I also like the simple way it just 
works without a driver.

Regards
Jon Westgate


Marcos D. Marado Torres wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>
>Sorry, in the previously e-mail I was wrong:
>
>You have to pass to the kernel:
>
>"psmouse_proto=imps" or "psmouse.psmouse_proto=imps", depending on if you have
>the psmouse support as module or built-in in the kernel.
>
>Hoping that helps,
>Mind Booster Noori
>
>- --
>==================================================
>Marcos Daniel Marado Torres AKA Mind Booster Noori
>/"\               http://student.dei.uc.pt/~marado
>\ /                       marado@student.dei.uc.pt
> X   ASCII Ribbon Campaign
>/ \  against HTML e-mail and Micro$oft attachments
>==================================================
>
>On Fri, 9 Jan 2004, Jon Westgate wrote:
>
>  
>
>>Hi,
>>I'm not sure if this is the right place to ask but if I run 2.6.1
>>I get mouse problems that I didn't get with 2.6.0
>>I'm running a compaq m300 (600MHz PIII) with a synaptics touch pad.
>>
>>In 2.6.0 there was an option to include or not include support for the
>>synaptics touchpad (I found that my touchpad worked just fine with that
>>option unchecked) in 2.6.1 that option is nolonger there.
>>
>>In 2.6.1 I find that the operation of the mouse is very erratic its
>>almost impossible to take your finger off the pad without the cursor
>>moving, Tapping doesn't work, The pad seems very accelerated (ie you
>>drag your finger a short distance and the cursor is at the other side of
>>the screen before you know it), Lastly if you dragged your finger to the
>>edge of the pad it used to continue on smoothly. This no longer works.
>>
>>My question is:
>>Is there a command line or append option I can put in lilo.conf to
>>prevent the synaptics driver from trying to reprogram my touchpad? I
>>quite like its default behavior. There is definatly something trying to
>>reprogram it as I have to turn off my laptop for it's behavior to return
>>to normal. Even if I reset it still needs a power cycle to fix it.
>>dmesg says my touchpad is this:
>>input: PS/2 Synaptics TouchPad on isa0060/serio4
>>
>>I'm not running any special drivers or settings in XF86Config
>>I just have /dev/input/mice setup with protocol set as ImPS/2
>>
>>Regards
>>Jon Westgate
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>    
>>
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.2.1 (GNU/Linux)
>Comment: Made with pgp4pine 1.76
>
>iD8DBQE//2NDmNlq8m+oD34RAiSBAJ44eUWjfj7LsNZug0Aq3fzG8ByWvgCgzHjb
>lWcACbs5tmGeIPGv80k1bjc=
>=lewM
>-----END PGP SIGNATURE-----
>
>
>
>  
>


