Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWENRK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWENRK3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 13:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWENRK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 13:10:29 -0400
Received: from xenotime.net ([66.160.160.81]:10925 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751029AbWENRK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 13:10:29 -0400
Date: Sun, 14 May 2006 10:12:54 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] Cleanups to Doc*/SubmittingPatches
Message-Id: <20060514101254.f731daf1.rdunlap@xenotime.net>
In-Reply-To: <20060514143037.GA2886@elf.ucw.cz>
References: <20060514143037.GA2886@elf.ucw.cz>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 May 2006 16:30:38 +0200 Pavel Machek wrote:

> This cleans up Submitting patches a bit. Missing/inconsistent full
> stops, mostly.

Incomplete sentences (fragments) don't need full stops, but they
should be consistent.

> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index c2c85bc..07b87ce 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -173,17 +173,17 @@ copy the maintainer when you change thei
>  For small patches you may want to CC the Trivial Patch Monkey
>  trivial@kernel.org managed by Adrian Bunk; which collects "trivial"
>  patches. Trivial patches must qualify for one of the following rules:
> - Spelling fixes in documentation
> + Spelling fixes in documentation.
>   Spelling fixes which could break grep(1).

I would just remove that '.' above and skip the rest of the
changes in this section.

> - Warning fixes (cluttering with useless warnings is bad)
> - Compilation fixes (only if they are actually correct)
> - Runtime fixes (only if they actually fix things)
> + Warning fixes (cluttering with useless warnings is bad).
> + Compilation fixes (only if they are actually correct).
> + Runtime fixes (only if they actually fix things).
>   Removing use of deprecated functions/macros (eg. check_region).
> - Contact detail and documentation fixes
> + Contact detail and documentation fixes.
>   Non-portable code replaced by portable code (even in arch-specific,
> - since people copy, as long as it's trivial)
> - Any fix by the author/maintainer of the file. (ie. patch monkey
> - in re-transmission mode)
> + since people copy, as long as it's trivial).
> + Any fix by the author/maintainer of the file (ie. patch monkey
> + in re-transmission mode).
>  URL: <http://www.kernel.org/pub/linux/kernel/people/bunk/trivial/>

---
~Randy
