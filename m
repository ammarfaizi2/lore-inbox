Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWB1TTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWB1TTy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWB1TTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:19:54 -0500
Received: from fmr20.intel.com ([134.134.136.19]:54690 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932448AbWB1TTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:19:52 -0500
Date: Tue, 28 Feb 2006 11:22:02 -0800
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: Mark Lord <liml@rtr.ca>
Cc: akpm@osdl.org, jgarzik@pobox.com, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2/13] ATA ACPI: debugging infrastructure
Message-Id: <20060228112202.5355ca43.randy_d_dunlap@linux.intel.com>
In-Reply-To: <440461AA.1090907@rtr.ca>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
	<20060222135133.3f80fbf9.randy_d_dunlap@linux.intel.com>
	<20060228114500.GA4057@elf.ucw.cz>
	<44043B4E.30907@pobox.com>
	<20060228041817.6fc444d2.akpm@osdl.org>
	<440461AA.1090907@rtr.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
X-Face: "}I"O`t9.W]b]8SycP0Jap#<FU!b:16h{lR\#aFEpEf\3c]wtAL|,'>)%JR<P#Yg.88}`$#
 A#bhRMP(=%<w07"0#EoCxXWD%UDdeU]>,H)Eg(FP)?S1qh0ZJRu|mz*%SKpL7rcKI3(OwmK2@uo\b2
 GB:7w&?a,*<8v[ldN`5)MXFcm'cjwRs5)ui)j
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2006 09:43:54 -0500
Mark Lord <liml@rtr.ca> wrote:

> Andrew Morton wrote:
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> >> Fine-grained 
> >>  message selection allows one to turn on only the messages needed, and 
> >>  only for the controller desired.
> > 
> > Except
> > 
> > - There's (presently) no way of making all the messages go away for a
> >   non-debug build.
> 
> Agreed.  We need a way to make them all really go away
> for embedded builds -- memory matters there.

That's a libata infrastructure issue, not an ATA-ACPI issue.
I'll go with whatever $maintainer decides.

~Randy
