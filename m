Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268497AbUJJVTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268497AbUJJVTt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 17:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268502AbUJJVTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 17:19:49 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:23450 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S268497AbUJJVTs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 17:19:48 -0400
Subject: Re: [ACPI] Re: [BKPATCH] LAPIC fix for 2.6
From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb@netcabo.pt>
Reply-To: sergiomb@netcabo.pt
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Len Brown <len.brown@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58L.0410102000160.4217@blysk.ds.pg.gda.pl>
References: <1097429707.30734.21.camel@d845pe>
	 <Pine.LNX.4.58.0410101044200.3897@ppc970.osdl.org>
	 <Pine.LNX.4.58L.0410102000160.4217@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1097443183.26647.31.camel@darkstar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 10 Oct 2004 22:19:43 +0100
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 10 Oct 2004 21:19:46.0461 (UTC) FILETIME=[DE255CD0:01C4AF0E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-10 at 20:04, Maciej W. Rozycki wrote:
> On Sun, 10 Oct 2004, Linus Torvalds wrote:
> 
> > > Hi Linus, please do a 
> > > 
> > > 	bk pull bk://linux-acpi.bkbits.net/26-latest-release
> > 
> > Ok, this version of the patch suddenly looks like a real bug-fix in that
> > it now makes the command line options "lapic"/"nolapic" a lot more
> > logical.
> 
>  Hmm, any particular reason to keep the local APIC disabled by default?  
> Most BIOS vendors keep it disabled just because it's easier to get stuff
> set up this way -- with the APIC enabled you need to do the same steps to
> program the 8259As as with the APIC disabled, plus program the APIC 
> itself, which provides no gain to BIOS itself or to DOS, so why bother?
> 
>   Maciej
> 

The problem is: trying enable some local apic's (for example on via
mother boards on my laptop), cause many problem, like hang on boot (with
ACPI), hang on Fn-F3 (video switch), power-off fails, etc. and no one
knows how resolved the problem.  
So keep it disable if BIOS vendors say so, can be reasonable idea.

-- 
Sérgio M. B.

