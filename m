Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266448AbRG1Ilt>; Sat, 28 Jul 2001 04:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266490AbRG1Ilj>; Sat, 28 Jul 2001 04:41:39 -0400
Received: from 20dyn97.com21.casema.net ([213.17.90.97]:41484 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S266448AbRG1Ila>; Sat, 28 Jul 2001 04:41:30 -0400
Message-Id: <200107280841.KAA24391@cave.bitwizard.nl>
Subject: NBD buglet......
To: linux-kernel@vger.kernel.org
Date: Sat, 28 Jul 2001 10:41:35 +0200 (MEST)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi,

I'm using NBD to stitch several dozens of 1G files together to one
block device. Thing is that can be done in several different ways, and
I haven't yet figured out the right set of parameters to pass to my
nbd-server. So, what happens is that I kill the nbd server, and
restart it. Turns out that the cache for the nbd device is not cleared
when the client quits!

Thus I see the old contents after restarting the server with different
parameters.... 

			Roger. 

P.S. CC-ed to Pavel, with wrong linux-kernel addr. Oops. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
