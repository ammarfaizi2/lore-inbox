Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWEMRIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWEMRIF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 13:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWEMRIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 13:08:05 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:44732 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932484AbWEMRIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 13:08:04 -0400
Date: Sat, 13 May 2006 13:07:46 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: gleb@minantech.com, mingo@elte.hu, akpm@osdl.org, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 00/02] update to Document futex PI design
In-Reply-To: <20060513100142.d437a6b2.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.58.0605131303100.27751@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605090954150.7007@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605100331290.31598@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605100429220.436@gandalf.stny.rr.com> <20060510101729.GB31504@elte.hu>
 <Pine.LNX.4.58.0605100657510.2485@gandalf.stny.rr.com> <20060510124600.GN5319@minantech.com>
 <Pine.LNX.4.58.0605100925190.4503@gandalf.stny.rr.com>
 <20060513100142.d437a6b2.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 13 May 2006, Randy.Dunlap wrote:

> On Wed, 10 May 2006 09:27:48 -0400 (EDT) Steven Rostedt wrote:
>
> >
> > Andrew,
> >
> > The following two patches update the rt-mutex-design.txt document.
> >
> > The first one simply removes all the tabs that I had in that document.
> > Since it's a document and not code, tabs are not really appropiate.
>
> I think that lots of people would not agree with that sentiment.
> Documentation/*.txt has approximately 8800 lines with tabs in them
> (just top-level Doc/*.txt, not sub-directories).

Yeah, but I have few ascii art graphs, as well as notes and points, that
would look funny if you don't have 8 character tabs.

But If the standand is to have tabs, then I would convert all 8
consecutive spaces to use tabs.  But the original document had a mix of
tabs and spaces that just looked horrible on different editors.  So I
decided to use spaces since that is more consistent, in the look.

But if this is not the norm, I'll supply a patch, otherwise I'll let it
be.

-- Steve

