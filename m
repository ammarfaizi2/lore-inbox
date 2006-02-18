Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWBRTxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWBRTxm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 14:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWBRTxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 14:53:42 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:26807
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932131AbWBRTxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 14:53:41 -0500
Date: Sat, 18 Feb 2006 11:53:27 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Muli Ben-Yehuda <mulix@mulix.org>,
       Christoph Hellwig <hch@infradead.org>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, openib-general@openib.org,
       SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Subject: Re: [PATCH 02/22] Firmware interface code for IB device.
Message-ID: <20060218195327.GA1382@kroah.com>
References: <20060218005532.13620.79663.stgit@localhost.localdomain> <20060218005707.13620.20538.stgit@localhost.localdomain> <20060218015808.GB17653@kroah.com> <aday809bewn.fsf@cisco.com> <20060218122011.GE911@infradead.org> <20060218122631.GA30535@granada.merseine.nu> <1140265955.4035.19.camel@laptopd505.fenrus.org> <adazmkoaaqr.fsf@cisco.com> <20060218181509.GA892@kroah.com> <adavevca48l.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adavevca48l.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 10:52:58AM -0800, Roland Dreier wrote:
>     Greg> Checking stuff into a private svn tree is vastly different
>     Greg> from posting to lkml in public.  In fact, it looks like the
>     Greg> svn tree is so far ahead of the in-kernel stuff, that most
>     Greg> people are just using it instead of the in-kernel code.
> 
> It's not a private svn tree -- the IBM ehca development is available
> to anyone via svn at https://openib.org/svn/gen2/trunk/src/linux-kernel/infiniband/hw/ehca

Sorry, I didn't mean to say "private", but rather, "seperate".
Doing kernel development in a seperate development tree from the
mainline kernel is very problematic, as has been documented many times
in the past.

> Distro politics are just distro politics -- and there will always be
> pressure on distros to ship stuff that's not upstream yet.

Luckily the distros know better than to accept this anymore, as they
have been burned too many times in the past...

thanks,

greg k-h
