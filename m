Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276952AbRJJVNf>; Wed, 10 Oct 2001 17:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276717AbRJJVNX>; Wed, 10 Oct 2001 17:13:23 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11276 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276075AbRJJVNN>; Wed, 10 Oct 2001 17:13:13 -0400
Subject: Re: Tainted Modules Help Notices
To: tkhoadfdsaf@hotmail.com (Concerned Programmer)
Date: Wed, 10 Oct 2001 22:17:22 +0100 (BST)
Cc: dwmw2@infradead.org (David Woodhouse), alan@lxorguk.ukuu.org.uk (Alan Cox),
        viro@math.psu.edu (Alexander Viro), kaos@ocs.com.au (Keith Owens),
        sirmorcant@morcant.org (Morgan Collins [Ax0n]),
        linux-kernel@vger.kernel.org
In-Reply-To: <OE64YU5ts1Tjkw1BzCf0000708c@hotmail.com> from "Concerned Programmer" at Oct 10, 2001 04:06:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15rQjC-0000m2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> had read that it was suppose to be for maintainability (.i.e. source
> available so kernel gods can debug) and not to enforce ideological
> conformity.  Now I read that anything not licensed under the GPL, including
> BSD or simply public domain source code, will taint my kernel and modprobe
> complains about non-GPL stuff including parport_pc which apparently did not
> have a license.  Should I expect a Linux kernel KGB to show up next?

Hardly. Its there to handle maintainability issues. Right now its got some 
glitches - and the BSD one is a glitch we need to sort out. Clearly BSD
stuff where the source is in the kernel is not harming anyones ability to
deubg.

>     Furthermore I have to agree with the previous poster.  Any module could
> easily lie to MODULE_LICENSE about its licensing terms and that would not
> make it's source automatically "free" and GPLable so I am now wondering if
> this tainting mechanism is of any use at all.

Well under the DMCA thats probably a criminal offence with five years in
jail. The truth however is that if you want to lie about licensing or run a
modutils that doesn't do it nobody stops you. Its there primarily to deal
with bug filtering from people who don't know better. Folks who know enough
to subvert the mechanism generally also know better than to post Nvdriver
bugs to l/k.

