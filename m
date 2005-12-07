Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVLGOe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVLGOe5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 09:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbVLGOe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 09:34:57 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:52164 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751101AbVLGOe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 09:34:56 -0500
Date: Wed, 7 Dec 2005 14:34:51 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>,
       Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Message-ID: <20051207143451.GB16938@srcf.ucam.org>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com> <20051206222001.GA14171@srcf.ucam.org> <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com> <20051207131454.GA16558@srcf.ucam.org> <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com> <58cb370e0512070626w735004afgf8cde34b8549fbdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0512070626w735004afgf8cde34b8549fbdc@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 03:26:45PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On 12/7/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > On 12/7/05, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > > On Wed, Dec 07, 2005 at 09:17:31AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > >
> > > > Isn't ide-io.c:ide_{start,complete}_power_step() enough?
> 
> Why feeding device with ACPI taskfile(s) can't be added to
> the existing suspend/resume state machine (ide_*_power_step)?

Oh, I see what you mean. Yes, I guess it ought to be ok at that stage.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
