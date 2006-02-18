Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWBRSxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWBRSxF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 13:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWBRSxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 13:53:05 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:9853 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932113AbWBRSxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 13:53:04 -0500
X-IronPort-AV: i="4.02,127,1139212800"; 
   d="scan'208"; a="407065025:sNHT35020288"
To: Greg KH <greg@kroah.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Muli Ben-Yehuda <mulix@mulix.org>,
       Christoph Hellwig <hch@infradead.org>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, openib-general@openib.org,
       SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Subject: Re: [PATCH 02/22] Firmware interface code for IB device.
X-Message-Flag: Warning: May contain useful information
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
	<20060218005707.13620.20538.stgit@localhost.localdomain>
	<20060218015808.GB17653@kroah.com> <aday809bewn.fsf@cisco.com>
	<20060218122011.GE911@infradead.org>
	<20060218122631.GA30535@granada.merseine.nu>
	<1140265955.4035.19.camel@laptopd505.fenrus.org>
	<adazmkoaaqr.fsf@cisco.com> <20060218181509.GA892@kroah.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Sat, 18 Feb 2006 10:52:58 -0800
In-Reply-To: <20060218181509.GA892@kroah.com> (Greg KH's message of "Sat, 18
 Feb 2006 10:15:09 -0800")
Message-ID: <adavevca48l.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 18 Feb 2006 18:52:59.0410 (UTC) FILETIME=[89A00720:01C634BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> Checking stuff into a private svn tree is vastly different
    Greg> from posting to lkml in public.  In fact, it looks like the
    Greg> svn tree is so far ahead of the in-kernel stuff, that most
    Greg> people are just using it instead of the in-kernel code.

It's not a private svn tree -- the IBM ehca development is available
to anyone via svn at https://openib.org/svn/gen2/trunk/src/linux-kernel/infiniband/hw/ehca

    Greg> I know at least one company has asked a distro to just
    Greg> accept the svn snapshot over the in-kernel IB code, which
    Greg> makes me wonder if the in-kernel stuff is even useful to
    Greg> people?  Why have it, if companies insist on using the
    Greg> out-of-tree stuff instead?

The IB driver stack is still in its early stages, so although I'm
pushing for things to be merged as fast as possible, the unfortunate
fact is that lots of things that people want to use (including the IBM
ehca driver) are not upstream and are not ready to go upstream yet.
But that doesn't mean we should give up on merging them.

Distro politics are just distro politics -- and there will always be
pressure on distros to ship stuff that's not upstream yet.

 - R.
