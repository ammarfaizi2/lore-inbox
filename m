Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWBRVcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWBRVcA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 16:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWBRVcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 16:32:00 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:26228 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932196AbWBRVcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 16:32:00 -0500
X-IronPort-AV: i="4.02,127,1139212800"; 
   d="scan'208"; a="407094593:sNHT35341888"
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
	<adavevca48l.fsf@cisco.com> <20060218195327.GA1382@kroah.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Sat, 18 Feb 2006 13:31:52 -0800
In-Reply-To: <20060218195327.GA1382@kroah.com> (Greg KH's message of "Sat,
 18 Feb 2006 11:53:27 -0800")
Message-ID: <adar7609wvr.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 18 Feb 2006 21:31:55.0644 (UTC) FILETIME=[BDA9DBC0:01C634D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> Sorry, I didn't mean to say "private", but rather,
    Greg> "seperate".  Doing kernel development in a seperate
    Greg> development tree from the mainline kernel is very
    Greg> problematic, as has been documented many times in the past.

As a general rule I agree with that.  However, the openib svn tree
we're talking about is not some project that is off in space never
merging with the kernel; as Christoph said, it's really just a staging
area for stuff that isn't ready for upstream yet.n

Perhaps it would be more politically correct to use git to develop
kernel code, but in the end that's really just a technical difference
that shouldn't matter.

    Roland> Distro politics are just distro politics -- and there will
    Roland> always be pressure on distros to ship stuff that's not
    Roland> upstream yet.

    Greg> Luckily the distros know better than to accept this anymore,
    Greg> as they have been burned too many times in the past...

OK, that's great.  But now I don't understand your original point.
You say there are people putting pressure on distros to ship what's in
openib svn rather than the upstream kernel, but if the distros are
going to ignore them, what does it matter?

And this thread started with me trying to help the IBM people make
progress towards merging a big chunk of that svn tree upstream.  That
should make you happy, right?

 - R.
