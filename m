Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWBQSpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWBQSpK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 13:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWBQSpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 13:45:10 -0500
Received: from smtp.enter.net ([216.193.128.24]:10258 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751121AbWBQSpD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 13:45:03 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Fri, 17 Feb 2006 15:45:21 -0500
User-Agent: KMail/1.8.1
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
References: <43EB7BBA.nailIFG412CGY@burner> <20060216181422.GA18837@merlin.emma.line.org> <43F5A5A4.nail2VC61NOF6@burner>
In-Reply-To: <43F5A5A4.nail2VC61NOF6@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200602171545.21867.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 February 2006 05:29, Joerg Schilling wrote:
> Matthias Andree <matthias.andree@gmx.de> wrote:
> > Joerg Schilling schrieb am 2006-02-16:
> > > Matthias Andree <matthias.andree@gmx.de> wrote:
> > > > > I usually fix real bugs immediately after I know them.
> > > >
> > > > "Usually" is the key here. Sometimes, you refuse to fix real bugs
> > > > forever even if you're made aware of them, and rather shift the blame
> > > > on somebody else.
> > >
> > > Show me a single real bug that I did not fix.
> >
> > Namespace split ATA/SCSI is unfixed in 2.01.01a06.
>
> The namne space split is a Linux kernel bug

Then why have I been talking about a unification with you?

I would quote your comments on it, but since that was a private mail I will 
not do so.

> > Bogus warnings about Linux are unfixed in said version.
>
> Warnings related to Linux kernel bugs

>From what I can tell a lot of the warnings are bogus. You even go to great 
lengths to "scare" people into only using "official" versions of cdrtools.

As to that, you have sections in the code marked "Do Not Change" and "Do Not 
Remove" - I checked the GPLv2 today (the one shipped with all versions of 
cdrecord I can find) and there is nothing in that which gives you the right 
to restrict what someone else does to your code.

Call it people being polite that nobody has removed that stuff from the 
existing primary port of cdrtools.

> > Bogus warnings about /dev/* are unfixed in said version.
>
> Warnings related to Linux kernel bugs

No. There is no Kernel bug in the SG_IO via /dev/hd* implementation.
While I can gloss over most other warnings, the following seem to be scare 
tactics to me:

cdrecord: Warning: Running on Linux-2.6.12-gentoo-r6
cdrecord: There are unsettled issues with Linux-2.5 and newer.
cdrecord: If you have unexpected problems, please try Linux-2.4 or Solaris.

Warning: Using badly designed ATAPI via /dev/hd* interface.

> > Linux uname() detection code is broken since 2.6.10 because it assumes
> > fixed-width fields.
>
> Warnings related to Linux kernel bugs

Since when is a function that doesn't handle a value returned not the source 
of a bug?

Show me the POSIX rules that say all fields returned by uname() have to have a 
certain fixed size.

DRH
