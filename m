Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289030AbSA3Jz4>; Wed, 30 Jan 2002 04:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289032AbSA3Jzq>; Wed, 30 Jan 2002 04:55:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19983 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289030AbSA3Jzh>; Wed, 30 Jan 2002 04:55:37 -0500
Subject: Re: A modest proposal -- We need a patch penguin
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 30 Jan 2002 10:06:35 +0000 (GMT)
Cc: viro@math.psu.edu (Alexander Viro),
        phillips@bonn-fries.net (Daniel Phillips), mingo@elte.hu,
        landley@trommello.org (Rob Landley), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201300110420.1542-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 30, 2002 01:21:09 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VrdT-0006t7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A "small stuff" maintainer may indeed be a good idea. The maintainer could
> be the same as somebody who does bigger stuff too, but they should be
> clearly different things - trivial one-liners that do not add anything
> new, only fix obvious stuff (to the point where nobody even needs to think
> about it - if I'd start getting any even halfway questionable patches from
> the "small stuff" maintainer, it wouldn't work).

So if someone you trusted actually started batching up small fixes and 
sending you things like

"37 random documentation updates - no code changed", "11 patches to fix
kmalloc checks", "maintainers updates to 6 network drivers"

that would work sanely ? I think that would actually fix a lot of the stuff 
getting lost right now. Its mostly small stuff, often from new people, or from
folks who met a bug, fixed it and have a totally seperate and rather more 
important (to them) project and deadline to meet that is going walkies.

It also increases bandwidth for sorting out the big stuff.

The other related question is device driver implementation stuff (not interfaces
and abstractions). You don't seem to check that much anyway, or have any taste
in device drivers 8) so should that be part of the small fixing job ?

Alan
