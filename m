Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268157AbUJDPQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268157AbUJDPQS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 11:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268168AbUJDPQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 11:16:18 -0400
Received: from sa11.bezeqint.net ([192.115.104.25]:48286 "EHLO
	sa11.bezeqint.net") by vger.kernel.org with ESMTP id S268157AbUJDPQN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 11:16:13 -0400
Date: Mon, 4 Oct 2004 18:17:22 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: linux-kernel@vger.kernel.org
Subject: Re: GPL Violation of Linux in Telsey Video Station Product
Message-ID: <20041004161722.GD6311@luna.mooo.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <41613F2F.2000706@ngi.it> <200410041344.45700.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410041344.45700.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 01:44:45PM +0000, Denis Vlasenko wrote:
> On Monday 04 October 2004 12:16, Alessandro Sappia wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Good Morning,
> > I'm a Customer of a broadband ISP in Italy; They sell ont only the
> > connection, but they add VoIP Phone and TVoIP. (Both TV on Demand and TV
> > Broadcasting).
> > I bought a Video Station branded by my carrier and surprisingly I found
> > that the operating system the use is a modified version of linux.
> > It was possible for me to see it because the Videostation Itself is just
> > a PC with an Ethernet Card on it and it does boot from remotely.
> 
> Does it itself contain Linux? It is possible that bootstrap
> tftp loader isn't Linux. In this case Videostation itself does not
> contain Linux until you turn it on.
> 
> But downloading Linux kernel and GPLed software via
> tftp and NFS is itself an act of distribution, and I think you
> have the right to obtain source from distributor (in this case,
> your ISP).
> 
> > I sniffed tftp traffic upon boot and in it it is possible to recognize
> > linux, over that the / dir is mounted over NFS and it was possible for
> > me to see more and more file belonging to it.
> > I then asked my seller if they use linux on my VideoStation and call
> > center tell me yes, but the call center people don't know where to find
> > source code of their linux version.
> > I contacted the the real producer of the videostation but they told me
> > the the contract they have with the carrier told they sell without OS
> > videostatiuons to them.
> > What to do now ?
> 
> Send text of GPL to the ISP and state that you'd like to get
> complete, buildable source tree for each GPLed binary component you
> received over the wire.

Note though that they will have to send you the kernel sources (or
point to the version they used) and compiled in modifications.

If their code is user-space then they don't have to send you their code,
provided that it isn't using any other user-space gpl code.

There is not problem with user-space proprietary code, as long as it
isn't derived work of other GPL user-space code.

Note that there is a debate whether closed-source kernel modules are
breaking the GPL (not linked in modification), and Linus state a few
times he won't act against such things (ati and nvidia distribute
closed source kernel modules).

Also with user-space, most libraries are lgpl or similar, and even if
not, its not always clear when dynamic linking is in violation of the
GPL (IANAL but my guess is that when there are alternatives that would
work without big modifications that its not, since its not derived work
in such a case).

> --
> vda
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>  
>  +++++++++++++++++++++++++++++++++++++++++++
>  This Mail Was Scanned By Mail-seCure System
>  at the Tel-Aviv University CC.
> 
