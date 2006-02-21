Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932719AbWBUJar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbWBUJar (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 04:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWBUJar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 04:30:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:13229 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932719AbWBUJaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 04:30:46 -0500
X-Authenticated: #428038
Date: Tue, 21 Feb 2006 10:30:42 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060221093042.GA14325@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org
References: <43EB7BBA.nailIFG412CGY@burner> <20060216181422.GA18837@merlin.emma.line.org> <43F5A5A4.nail2VC61NOF6@burner> <200602171545.21867.dhazelton@enter.net> <43F9D95C.nail4AL61JSZG@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F9D95C.nail4AL61JSZG@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-20:

> I did not get any proposal for working on making ide-scsi work

The suggestion was not to insist on it.

> nor did I get a useful proposal that would explain how it might be
> done without ide-scsi.

The existing code works good enough for the cdrecord "consumer" of your
libscg library when the scary warnings are dropped.

Problems with new hardware can be fixed as use cases and hardware appear
and real problems show up. Given that the Linux device layering is
documented as passing unknown ioctls to lower layers to see if they can
deal with them, there shouldn't be many issues.

If you're unware of problems with new hardware or inventions, nobody can
seriously blame you, just stuff "last found working with Linux 2.6.y"
into some readme file and that's it.

> > From what I can tell a lot of the warnings are bogus. You even go to great 
> > lengths to "scare" people into only using "official" versions of cdrtools.
> 
> They are related to serious problems.

They are related to problems that you encountered with a SUSE version
ages ago, else your commentary in the code is insufficient.

You ought to check once a year or once every two years if the problems
you are so heftily complain about persist in supported versions; for
instance, any SUSE warnings related to 8.X versions can be removed and
replaced by a note that you don't intend to support operating systems
that are no longer supported by their respective vendor. You don't have
support contracts with distributors, so they aren't obliged to tell you
"hey we fixed that bug" -- and if you asked, you'd probably get a useful
answers.

I'm applying the same policy to my software (no support on unsupported
distributions) and it hasn't caused a single complaint yet, the only
comments I received were apologies for having to use obsolete systems
for some reasons, with people being rather modest and cooperative, like
offering testing, accounts on those systems and so on. Pretty reasonable
all in all IMO.

-- 
Matthias Andree
