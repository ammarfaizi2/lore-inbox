Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267808AbTBVEZe>; Fri, 21 Feb 2003 23:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267811AbTBVEZd>; Fri, 21 Feb 2003 23:25:33 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:47271 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S267808AbTBVEZc>;
	Fri, 21 Feb 2003 23:25:32 -0500
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.62
References: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com>
	<3E536237.8010502@blue-labs.org> <20030219185017.GA6091@gemtek.lt>
	<87k7fucmjb.fsf@lapper.ihatent.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 22 Feb 2003 06:34:13 +0100
In-Reply-To: <87k7fucmjb.fsf@lapper.ihatent.com>
Message-ID: <878yw8anfu.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis <alexh@ihatent.com> writes:

> Zilvinas Valinskas <zilvinas@gemtek.lt> writes:
> 
> > On Wed, Feb 19, 2003 at 05:53:43AM -0500, David Ford wrote:
> > > 2.5.60+ is rather unstable for me on an Athlon CPU w/ gcc 3.2.2.  If I'm 
> > > careful and do very little in X, it seems to stay up for a few days.  If 
> > > I do any sort of fast graphics or sound, etc, it'll die very quickly.  
> > > 'tis an instant death with no OOPS, nothing at all on screen, nothing on 
> > > serial console.
> > > 
> > > Just an FYI, I'm trying to narrow it down.
> > 
> > it might triple fault ? Who knows. One thing I am sure of, if I don't
> > load agpgart + intel-agp, laptop in questions, works flawlessly.
> > Otherwise first time I log of KDE trying to login as different user I
> > get instant reboot.
> > 
> 
> I'm seeing the same on my Evo800c, I think it's very much
> ACPI-related, as logging out of gnome and back in worked before i got
> a newer ACPI-patch on 2.4. Currently on 2.4.20 with ACPI patch from
> early January.
> 
> Planning on testing out the latest ACPI-patch dates February 18th
> along with 2.4.21-pre4 now; and tinker a bit with the DSDT to make it
> usefull; I'll let you know how it works out.
>

Made a new kernel, 2.4.21-pre4 with ACPI form 0218 patched it, and
recompiled. Running with the builtin its fine, and my own supplied DSDT the
machine will instantly reboot when hitting the logout-button in Gnome
2.2.

How do I get a way of telling exactly what went pear shaped whe the
machine just reboots like that?

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
