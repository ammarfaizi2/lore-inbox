Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278267AbRJMEw3>; Sat, 13 Oct 2001 00:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278268AbRJMEwT>; Sat, 13 Oct 2001 00:52:19 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:32517 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S278267AbRJMEwA>;
	Sat, 13 Oct 2001 00:52:00 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200110130452.f9D4qG9288830@saturn.cs.uml.edu>
Subject: Re: No love for the PPC
To: mike@nerv-9.net (Mike Borrelli)
Date: Sat, 13 Oct 2001 00:52:16 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0110121002200.13818-100000@asuka.nerv-9.net> from "Mike Borrelli" at Oct 12, 2001 10:08:39 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Borrelli writes:

> I'm sorry about the tone of this e-mail, but it is somewhat painful when,
> after downloading a new kernel to play with, it doesn't compile on the
> ppc.  It isn't even big problems either.  A single line (#include
> <linux/pm.h>) is missing from pc_keyb.c and has been for at least three
> -ac releases.  Now, process.c in arch/ppc/kernel/ dies from an undeclared
> identifier (init_mmap).
...
> Anyway, the real question is, why does the ppc arhitecture /always/ break
> between versions?

At the most recent Ottata Linux Symposium, there was a PowerPC
session with about 20 people. Somebody did a poll, asking what
people used. I was the only person who dared to use a kernel
from Linus. Everone else was using the BenH and BitKeeper ones.

This is a sorry state of affairs. If people are off using kernels
from other places, there isn't a great incentive to keep the
official Linus kernel updated. Nobody uses it anyway.

Elimination of these non-Linus PowerPC trees would be great.
(at least the "stable" ones should go, as they lure people
away from the one true source tree)



