Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbTHXVAw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 17:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbTHXVAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 17:00:52 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:35028 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261317AbTHXU7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 16:59:46 -0400
Date: Sun, 24 Aug 2003 22:59:38 +0200 (MEST)
Message-Id: <200308242059.h7OKxcCD028193@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: smiler@lanil.mine.nu, zwane@linuxpower.ca
Subject: Re: Pentium-M?
Cc: barryn@pobox.com, linux-kernel@vger.kernel.org, lkml@kcore.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Aug 2003 22:20:13 +0200, Christian Axelsson <smiler@lanil.mine.nu> wrote:
>Hmm.. I have compiled my whole system with -march=pentium4 and yet not 
>had a single breakage. Are you sure that this is p3?

Oh yes. The core is most definitely P6+tweaks and not NetBurst.
This can be deduced from facts like:
- CPUID family is 6 not 15
- performance counter architecture is like PIII with some minor
  tweaks but definitely nothing like P4
- treated separately from NetBurst in code optimization manual

The reason compiling with -march=pentium4 doesn't break is that
the differences ISA-wise are almost nil.

/Mikael
