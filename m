Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWERPZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWERPZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWERPZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:25:28 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:63736 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751316AbWERPZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:25:27 -0400
Subject: Re: [RFC] [Patch 4/6] statistics infrastructure - documentation
From: Martin Peschke <mp3@de.ibm.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, chase.venters@clientec.com,
       nickpiggin@yahoo.com.au, kaos@ocs.com.au, akpm@osdl.org,
       clameter@sgi.com, fche@redhat.com, peterc@gelato.unsw.edu.au,
       hch@infradead.org, arjan@infradead.org, ak@suse.de
In-Reply-To: <20060517233343.1d5517dc.rdunlap@xenotime.net>
References: <1147892085.3076.20.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	 <20060517233343.1d5517dc.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Thu, 18 May 2006 17:25:24 +0200
Message-Id: <1147965924.2987.8.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-17 at 23:33 -0700, Randy.Dunlap wrote:
> On Wed, 17 May 2006 20:54:45 +0200 Martin Peschke wrote:
> 
> > documentation for developers and users
> >
[ snipped ]

Thanks reading carefully. Good catches. I fixed them all.

> > +	Why debugfs for now
> > +
> > +While sysfs comes with a refined structure reflecting almost everything
> > +in the system, it is (by design) not good at representing large and variable
> > +amounts of data, that is, more than one value per file. As for statistics,
> > +we could make good use of the former, but not of the latter.
> 
> Why is debugfs not suitable for large & variable amounts of data?
> Please expand/explain.

It might have been confusing that I started off discussing _sysfs_ (and
why it doesn't suit my needs in some regards). Debugfs is fine.

> > +	Locating statistics
> > +
> > +The statistics infrastructure's user interface is in the
> > +/sys/kernel/debug/statistics directory, assuming debugfs has been mounted at
> > +/sys/kernel/debug.  The "statistics" directory holds interface subdirectories
> > +created on the behalf of exploiters, for example:
> 
> I'm curious:
> Is /sys/kernel/debug a common mount point for debugfs ?

I would think so.

	Martin

