Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130075AbQLRT4Q>; Mon, 18 Dec 2000 14:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130150AbQLRT4H>; Mon, 18 Dec 2000 14:56:07 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:14605 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S130075AbQLRTz7>; Mon, 18 Dec 2000 14:55:59 -0500
Date: Mon, 18 Dec 2000 11:21:33 -0800 (PST)
From: ferret@phonewave.net
To: Peter Samuelson <peter@cadcamlab.org>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        Dana Lacoste <dana.lacoste@peregrine.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: Linus's include file strategy redux
In-Reply-To: <20001217215831.V3199@cadcamlab.org>
Message-ID: <Pine.LNX.3.96.1001218105326.3555A-100000@tarot.mentasm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Dec 2000, Peter Samuelson wrote:

> 
> [ferret@phonewave.net]
> > One last question: WHY is the kernel's top-level Makefile handling
> > this symlink?
> 
> Where do you think it should be handled?  'make modules_install' seems
> like the most logical place, to me.

I think making the symlink should be handled outside the proper scope of
the top-level Makefile, for reasons I have brought up earlier in this
discussion; The Makefile is simply not equipped to know the full state of
the system it is being run for outside the simple case of one single
machine.


s/WHY is/For which specific reasons is/

Anyway, the associated discussions cleared up nearly all the
technical-related questions I had. The remaining questions relate toward
policy-issues orthogontal to implementation details. I am still a little
unclear on the nature of the problem this symlink is meant to solve.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
