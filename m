Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267265AbTAAQYS>; Wed, 1 Jan 2003 11:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267266AbTAAQYR>; Wed, 1 Jan 2003 11:24:17 -0500
Received: from [81.2.122.30] ([81.2.122.30]:41991 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267265AbTAAQYR>;
	Wed, 1 Jan 2003 11:24:17 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301011632.h01GWOdn001749@darkstar.example.net>
Subject: Re: [RFC] top-level config menu dependencies
To: szepe@pinerecords.com (Tomas Szepe)
Date: Wed, 1 Jan 2003 16:32:23 +0000 (GMT)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030101162519.GF15200@louise.pinerecords.com> from "Tomas Szepe" at Jan 01, 2003 05:25:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It has been a long-time tradition that no "real tunable options" are
> present in the top level of the kernel config menu.  I reckon this has
> to do with an inherent limitation of the original config subsystem.
> 
> While converting the way submenus appear in menuconfig depending on
> their main, parent config option, I stumbled upon certain subsystems
> (such as MTD or IrDA) that should clearly have an on/off switch directly
> in the main menu so that one doesn't have to enter the corresponding
> submenus to even see if they're enabled or disabled.
> 
> Since the new kernel configurator would have no problems with such
> a setup, I'm posting this RFC to get the general opinion on whether
> this should be carried on with.  I'm willing to create and send in
> the patches.

Why not?  The config system is changing so much between 2.4 and 2.5
anyway, so any re-organisation like that might as well be done in one
go now, rather than during the 2.7 development cycle.

Oh, except that we are in a feature freeze :-), but that doesn't seem
to have affected anything else.  Infact, I think the current state
should be called a

"feature latent-heat-transition-between-melted-and-frozen".

John.
