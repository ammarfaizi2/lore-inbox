Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268243AbRHBAu5>; Wed, 1 Aug 2001 20:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268266AbRHBAus>; Wed, 1 Aug 2001 20:50:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4365 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268243AbRHBAuk>; Wed, 1 Aug 2001 20:50:40 -0400
Subject: Re: booting SMP P6 kernel on P4 hangs.
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 2 Aug 2001 01:51:46 +0100 (BST)
Cc: arjanv@redhat.com (Arjan van de Ven), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108010917540.20829-100000@penguin.transmeta.com> from "Linus Torvalds" at Aug 01, 2001 09:18:57 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15S6iI-00089C-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 1 Aug 2001, Arjan van de Ven wrote:
> > >
> > > It should boot, and it looks like the problem may be a bad MP table.
> >
> > Oh it is. And it's due to a recommendation Intel makes to bios writers.
> > As a result, every P4 I've encountered shares this bug. Intel knows it's
> > an invalid MP table, but refuses to change the recommendation.
> 
> What's the recommendation? We might be able to change the specific code in
> question..
> 
> Or are they just trying to strongarm the move to the horrid ACPI tables?

They are certainly involved in the latter but whether this is related  or 
a seperate evil empire scheme is open to question

