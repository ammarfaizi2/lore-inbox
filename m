Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271904AbRHVAVo>; Tue, 21 Aug 2001 20:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271902AbRHVAVe>; Tue, 21 Aug 2001 20:21:34 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26633 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271904AbRHVAV3>; Tue, 21 Aug 2001 20:21:29 -0400
Subject: Re: Qlogic/FC firmware
To: jfbeam@bluetopia.net (Ricky Beam)
Date: Wed, 22 Aug 2001 01:24:29 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0108211927570.6389-100000@sweetums.bluetronic.net> from "Ricky Beam" at Aug 21, 2001 07:32:56 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZLor-0000cl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 21 Aug 2001, Alan Cox wrote:
> >Look, if its not distributable then its no good to anyone.
> 
> Who said it wasn't distributable?  The license in the 2.4.5 file doesn't say
> you cannot distribute it.  It doesn't even prevent you from sell it.  You have
> to leave the notice intact and not use it as a means to attach the Qlogic
> mark to any derived product.

 * 2. Redistribution in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.

Which is a problem because the kernel is GPL, that isnt GPL compatible
and until this was pointed out nobody has been going to print their blurb
in all the manuals - because after all it says GPL.

Licenses cannot be ignored. If I merge non GPL compliant code I'm doing to
the contributors to the kernel the very same thing people pirating windows
do to microsoft. 

> Other than it's age, I see *zero* reason to remove it from the tree.

Well let me quote from it again

/*
 *     W     W     A     RRRR    N   N   IIIII   N   N    GGG
 *     W     W    A A    R   R   N   N     I     N   N   G   G
 *     W     W   A   A   R  R    NN  N     I     NN  N   G  
 *     W  W  W   AAAAA   RRR     N N N     I     N N N   G  GG
 *     W  W  W   A   A   R R     N  NN     I     N  NN   G   G
 *     W W W W   A   A   R  R    N   N     I     N   N   G   G
 *      W   W    A   A   R   R   N   N   IIIII   N   N    GGGG
 *
 *         This version of firmware is a release candidate,
 *     design verification testing (DVT) has not been completed.
 */

or in simple terms "might lose all your data"

> >Well maybe, and whats the right way to do that, oh my god I do believe its
> >an initrd.
> 
> __init_data

Doesnt work in modules. See previous twice repeated discussion. 

As Matthew has noted, we have a source of newer firmware, and because the
sparc's have this annoying firmware problem it is going to be appropriate
to add build in firmware as a config option (probably set with def_bool on
sparc..)

At the time a) I didnt realise the sparc setup was so anal, and b) I didnt
know about the firmware update.

Alan
