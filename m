Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267429AbTBUNHP>; Fri, 21 Feb 2003 08:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267430AbTBUNHP>; Fri, 21 Feb 2003 08:07:15 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:16551 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S267429AbTBUNHO>;
	Fri, 21 Feb 2003 08:07:14 -0500
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.62
References: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com>
	<3E536237.8010502@blue-labs.org> <20030219185017.GA6091@gemtek.lt>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 21 Feb 2003 04:58:32 +0100
In-Reply-To: <20030219185017.GA6091@gemtek.lt>
Message-ID: <87k7fucmjb.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zilvinas Valinskas <zilvinas@gemtek.lt> writes:

> On Wed, Feb 19, 2003 at 05:53:43AM -0500, David Ford wrote:
> > 2.5.60+ is rather unstable for me on an Athlon CPU w/ gcc 3.2.2.  If I'm 
> > careful and do very little in X, it seems to stay up for a few days.  If 
> > I do any sort of fast graphics or sound, etc, it'll die very quickly.  
> > 'tis an instant death with no OOPS, nothing at all on screen, nothing on 
> > serial console.
> > 
> > Just an FYI, I'm trying to narrow it down.
> 
> it might triple fault ? Who knows. One thing I am sure of, if I don't
> load agpgart + intel-agp, laptop in questions, works flawlessly.
> Otherwise first time I log of KDE trying to login as different user I
> get instant reboot.
> 

I'm seeing the same on my Evo800c, I think it's very much
ACPI-related, as logging out of gnome and back in worked before i got
a newer ACPI-patch on 2.4. Currently on 2.4.20 with ACPI patch from
early January.

Planning on testing out the latest ACPI-patch dates February 18th
along with 2.4.21-pre4 now; and tinker a bit with the DSDT to make it
usefull; I'll let you know how it works out.

> 
> Compaq EVO 800
> Intel P4, 1.7GHz, 256MB RAM, ATI Radeon Mobility LY (something).
> 

Got the same box, only 512Mb more RAM ;)

mvh,
A

-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
