Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289518AbSAOMbl>; Tue, 15 Jan 2002 07:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289523AbSAOMbX>; Tue, 15 Jan 2002 07:31:23 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:14598 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S289518AbSAOMbL>; Tue, 15 Jan 2002 07:31:11 -0500
Date: Tue, 15 Jan 2002 13:31:08 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <esr@thyrsus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery --
 the elegant solution)
In-Reply-To: <E16QGVZ-0003Ky-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201151228540.11441-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Alan Cox wrote:

> > > Because the GPL says he's entitled to them ?
> > 
> > You miss my point.  Sure he's entitled to them.  But why should he
> > *have to have them*?  They're extra state which, in the presence
> > of a proper autoconfigurator, he doesn't need.
> 
> You have it backwards. The _autoconfigurator_ is extra state which in the
> presence of the config he doesn't need
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Alan, Eric (and others, too), please.
Of course the autoconfigurator is an useful piece of software.
And of course Eric is posting to the wrong list here. Kernel developers
don't need any autoconfigurator at all (yes, it's just "extra state").

Eric, Aunt Tillie doesn't need any custom-made, untested, probably not
working kernel. QA comes at a price. The lastest VM fix may take a while
to reach mainstream kernels. That's life.

Face it, you're under the wrong assumption that Alan's 2.2 or Marcelo's 2.4
vanilla kernels are "better" than their patched counterparts shipped by
distro vendors. This is far from the truth[*]. Only very recent 2.2 kernels
can be installed on a Red Hat 6.x with little pain. Call it Red Hat's fault,
or mine, for choosing RH, (it's not Alan's of course), but I wanted
RAID 0.90 from the beginning.
Maybe today you can upgrade most 2.4-based distros to the latest Marcelo's,
but I bet it's going to change as soon as vendors start patching their own
kernels with random backports from 2.5.

No matter how you put it, 99% of the times your autoconfigurator will
produce a previuosly untested configuration. We can discuss about release
policies forever, but Marcelo isn't expected to replicate all the QA job
vendors do before releasing a kernel. Now, the kernel is modular
enough not to turn the issue into a nightmare for the average developer.
Most of the time you DO keep your old .config around. And you know your HW.
And the vanilla kernel you've just compiled happens to work. But you'd
better do some testing before putting it on any production box.
And of course, I consider Aunt Tillie's PC definitely "production".

In the end, I think you're just pushing the right piece of software
on the wrong list. IMHO, endusers compiling the kernel it's not an l-k
issue, it's a distro one.

[*] That is, from Aunt Tillie's standpoint.

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it


