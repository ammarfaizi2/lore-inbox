Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273128AbRIJBqn>; Sun, 9 Sep 2001 21:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273133AbRIJBqe>; Sun, 9 Sep 2001 21:46:34 -0400
Received: from c1123685-a.crvlls1.or.home.com ([65.12.164.15]:33039 "EHLO
	inbetween.blorf.net") by vger.kernel.org with ESMTP
	id <S273128AbRIJBqZ>; Sun, 9 Sep 2001 21:46:25 -0400
Date: Sun, 9 Sep 2001 18:46:43 -0700 (PDT)
From: Jacob Luna Lundberg <kernel@gnifty.net>
Reply-To: jacob@chaos2.org
To: Joe Fago <cfago@tconl.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9: PDC20267 not working
In-Reply-To: <3B9C16AF.8F1599E6@tconl.com>
Message-ID: <Pine.LNX.4.21.0109091843220.31509-100000@inbetween.blorf.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Sep 2001, Joe Fago wrote:

> System hangs on boot:

> PDC20267: IDE controller on PCI bus 00 dev 40

> This is the only device attached to the controller. Any suggestions?

I have seen this before.  I have a system that will do it every time right
now, in fact.  You can try setting interrupts to edge-triggered in your
BIOS if it has such an option; this usually ``fixes'' the problem for me.
Of course, it will mean you can't share PCI interrupts, if I understand it
correctly.  However, I'm not sure what's going on and nobody has commented
on it thus far that I know of.  :(

-Jacob

