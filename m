Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130772AbQK0BQE>; Sun, 26 Nov 2000 20:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132295AbQK0BPy>; Sun, 26 Nov 2000 20:15:54 -0500
Received: from 13dyn186.delft.casema.net ([212.64.76.186]:45063 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S130772AbQK0BPi>; Sun, 26 Nov 2000 20:15:38 -0500
Message-Id: <200011270045.BAA13121@cave.bitwizard.nl>
Subject: Re: Universal debug macros.
In-Reply-To: <Pine.LNX.4.10.10011270109020.11180-100000@yle-server.ylenurme.sise>
 from Elmer Joandi at "Nov 27, 2000 01:30:06 am"
To: Elmer Joandi <elmer@ylenurme.ee>
Date: Mon, 27 Nov 2000 01:45:33 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elmer Joandi wrote:
> 
> 
> On Sun, 26 Nov 2000, Rogier Wolff wrote:
> > Sure it will slow the driver down a bit, because of all those bit-test
> > instructions in the driver. If it bothers you, you get to turn it
> > off. If you are capable of that, you are also capable enough to turn
> > it back on when neccesary.
> 
> Now if there would be simple _unified_ system for switching debug code
> on/off, it would be a real win. That  recompilation-capable enduser would
> not need much knowledge to go "General Setup" or newly created
> "Optimization" section and switch debugging off/on for _all_ network
> drivers or ide drivers for example.

Now, how is say "Red Hat" (*) going to ship kernels? Of course they are
going to turn off debugging. Then I'll be stuck with a non-recompiling
user-in-trouble with a non-debugging-enabled kernel. 

Clients whom I have to tell "please read the kernel-howto" and
recompile your kernel. It's not that hard will not feel "good" about
this. It may seem easy to you, but from some people it is not.


				Roger.

(*) Even if I manage to convince Red Hat not to do this, some
distribution is going to claim that they distribute the "performance"
kernel, and disable debugging in the field. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
