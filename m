Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWC2VYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWC2VYe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 16:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWC2VYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 16:24:34 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:29711 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1750815AbWC2VYe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 16:24:34 -0500
To: Rob Landley <rob@landley.net>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Eric Piel <Eric.Piel@tremplin-utc.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
Subject: Re: [OT] Non-GCC compilers used for linux userspace
References: <200603141619.36609.mmazur@kernel.pl>
	<442960B6.2040502@tremplin-utc.net>
	<7E2F0C3C-4091-4EEB-8E10-C1F58F94BD59@mac.com>
	<200603281647.06020.rob@landley.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: (setq software-quality (/ 1 number-of-authors))
Date: Wed, 29 Mar 2006 22:23:44 +0100
In-Reply-To: <200603281647.06020.rob@landley.net> (Rob Landley's message of
 "Tue, 28 Mar 2006 16:47:05 -0500")
Message-ID: <87irpxvtb3.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006, Rob Landley announced authoritatively:
> I play with Fabrice Bellard's Tiny C Compiler (http://www.tinycc.org), and 
> hope to get a distro compiled with it someday, at least as a proof of 
> concept.

It's a nifty idea, a sort of uClibc of C compilers. Alas it's useless on
almost all my systems because it's x86-only by design...

> That aims for full c99 and is already implementing a lot of gcc stuff too.

Good for it, as long as it doesn't go on to define __GNUC__ like icc did
at one point (even though it doesn't implement all GCC
extensions)... but Fabrice is sane so I doubt he'd do anything that
loopy.

-- 
`Come now, you should know that whenever you plan the duration of your
 unplanned downtime, you should add in padding for random management
 freakouts.'
