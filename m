Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVFUPG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVFUPG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVFUPG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:06:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27558 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262082AbVFUPGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:06:22 -0400
Date: Tue, 21 Jun 2005 06:44:57 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tim Bird <tim.bird@am.sony.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: -mm -> 2.6.13 merge status (Suspend-to-disk)
Message-ID: <20050621094457.GB20197@logos.cnet>
References: <20050620235458.5b437274.akpm@osdl.org> <1119359295.10186.1150.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119359295.10186.1150.camel@localhost>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > execute-in-place
> > 
> >     Will merge.  Have the embedded guys commented on the usefulness of
> >     this for execute-out-of-ROM?
> 
> Switch roles for a mo and put my Cyclades hat on. Probably not useful to
> us at the moment, at least in the case of the products I work on.
> Marcelo?

Well yes, its definately very useful for embedded folks where RAM is a 
precious resource (not our case at the moment).

I'm not aware of any users of this XIP implementation, maybe Tim Bird or 
Russell have reviewed/tested it? 

It went through filesystem folks reviewing (and I'm pretty sure akpm knows
about that already)...

Hope to be helpful.
