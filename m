Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWBRSTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWBRSTg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 13:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWBRSTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 13:19:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:9920 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932106AbWBRSTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 13:19:36 -0500
Date: Sat, 18 Feb 2006 18:19:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Roland Dreier <rdreier@cisco.com>, Arjan van de Ven <arjan@infradead.org>,
       Muli Ben-Yehuda <mulix@mulix.org>,
       Christoph Hellwig <hch@infradead.org>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, openib-general@openib.org,
       SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Subject: Re: [PATCH 02/22] Firmware interface code for IB device.
Message-ID: <20060218181932.GA6410@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Roland Dreier <rdreier@cisco.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Muli Ben-Yehuda <mulix@mulix.org>,
	Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc64-dev@ozlabs.org, openib-general@openib.org,
	SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
	MEDER@de.ibm.com
References: <20060218005532.13620.79663.stgit@localhost.localdomain> <20060218005707.13620.20538.stgit@localhost.localdomain> <20060218015808.GB17653@kroah.com> <aday809bewn.fsf@cisco.com> <20060218122011.GE911@infradead.org> <20060218122631.GA30535@granada.merseine.nu> <1140265955.4035.19.camel@laptopd505.fenrus.org> <adazmkoaaqr.fsf@cisco.com> <20060218181509.GA892@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218181509.GA892@kroah.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 10:15:09AM -0800, Greg KH wrote:
> On Sat, Feb 18, 2006 at 08:32:28AM -0800, Roland Dreier wrote:
> >     Arjan> The bigger issue is: if people can't be bothered to do
> >     Arjan> those steps, why would they be bothered to do this for
> >     Arjan> maintenance and bugfixes etc etc?  Basically it's now
> >     Arjan> already a de-facto unmaintained driver....
> > 
> > I don't think that's really a fair statement.  The IBM people have
> > been active and responsive in maintaining their driving in the
> > openib.org svn tree.  However, they asked me to post their driver for
> > review because it would be difficult for them to do it.
> 
> Checking stuff into a private svn tree is vastly different from posting
> to lkml in public.  In fact, it looks like the svn tree is so far ahead
> of the in-kernel stuff, that most people are just using it instead of
> the in-kernel code.
> 
> I know at least one company has asked a distro to just accept the svn
> snapshot over the in-kernel IB code, which makes me wonder if the
> in-kernel stuff is even useful to people?  Why have it, if companies
> insist on using the out-of-tree stuff instead?

The openib tree isn't private.  It's mostly just a staging area for
development.  Any company that wants it included into a distro release
is completely clueless.
