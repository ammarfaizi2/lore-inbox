Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWBRSPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWBRSPc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 13:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWBRSPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 13:15:32 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:64742
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932104AbWBRSPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 13:15:31 -0500
Date: Sat, 18 Feb 2006 10:15:09 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Muli Ben-Yehuda <mulix@mulix.org>,
       Christoph Hellwig <hch@infradead.org>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, openib-general@openib.org,
       SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Subject: Re: [PATCH 02/22] Firmware interface code for IB device.
Message-ID: <20060218181509.GA892@kroah.com>
References: <20060218005532.13620.79663.stgit@localhost.localdomain> <20060218005707.13620.20538.stgit@localhost.localdomain> <20060218015808.GB17653@kroah.com> <aday809bewn.fsf@cisco.com> <20060218122011.GE911@infradead.org> <20060218122631.GA30535@granada.merseine.nu> <1140265955.4035.19.camel@laptopd505.fenrus.org> <adazmkoaaqr.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adazmkoaaqr.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 08:32:28AM -0800, Roland Dreier wrote:
>     Arjan> The bigger issue is: if people can't be bothered to do
>     Arjan> those steps, why would they be bothered to do this for
>     Arjan> maintenance and bugfixes etc etc?  Basically it's now
>     Arjan> already a de-facto unmaintained driver....
> 
> I don't think that's really a fair statement.  The IBM people have
> been active and responsive in maintaining their driving in the
> openib.org svn tree.  However, they asked me to post their driver for
> review because it would be difficult for them to do it.

Checking stuff into a private svn tree is vastly different from posting
to lkml in public.  In fact, it looks like the svn tree is so far ahead
of the in-kernel stuff, that most people are just using it instead of
the in-kernel code.

I know at least one company has asked a distro to just accept the svn
snapshot over the in-kernel IB code, which makes me wonder if the
in-kernel stuff is even useful to people?  Why have it, if companies
insist on using the out-of-tree stuff instead?

thanks,

greg k-h
