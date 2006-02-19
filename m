Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWBSAJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWBSAJi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 19:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWBSAJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 19:09:38 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:49178 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932363AbWBSAJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 19:09:37 -0500
X-IronPort-AV: i="4.02,127,1139212800"; 
   d="scan'208"; a="407126704:sNHT35520532"
To: Greg KH <greg@kroah.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Muli Ben-Yehuda <mulix@mulix.org>,
       Christoph Hellwig <hch@infradead.org>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, openib-general@openib.org,
       SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Subject: Re: [PATCH 02/22] Firmware interface code for IB device.
X-Message-Flag: Warning: May contain useful information
References: <20060218015808.GB17653@kroah.com> <aday809bewn.fsf@cisco.com>
	<20060218122011.GE911@infradead.org>
	<20060218122631.GA30535@granada.merseine.nu>
	<1140265955.4035.19.camel@laptopd505.fenrus.org>
	<adazmkoaaqr.fsf@cisco.com> <20060218181509.GA892@kroah.com>
	<adavevca48l.fsf@cisco.com> <20060218195327.GA1382@kroah.com>
	<adar7609wvr.fsf@cisco.com> <20060218232934.GA2624@kroah.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Sat, 18 Feb 2006 16:09:31 -0800
In-Reply-To: <20060218232934.GA2624@kroah.com> (Greg KH's message of "Sat,
 18 Feb 2006 15:29:34 -0800")
Message-ID: <adamzgo9pl0.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 19 Feb 2006 00:09:32.0381 (UTC) FILETIME=[C25168D0:01C634E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> Yes, that doesn't matter.  But it seems that the svn tree is
    Greg> vastly different from the in-kernel code.  So much so that
    Greg> some companies feel that the in-kernel stuff just isn't
    Greg> worth running at all.

I don't want to belabor this issue... but the svn tree is not vastly
different than what's in the kernel.  It has some things that aren't
upstream yet, and which are important to some people.  For example,
the IBM ehca driver we're talking about, as well as the PathScale
driver, SDP (sockets direct protocol), etc.  It just takes time for
this new code to get to the point where both the developers of the new
stuff feel it's ready to be merged, and the kernel community agrees
that it should be merged.

    Greg> Yes, that does make me happy.  But it doesn't make me happy
    Greg> to see IBM not being able to participate in kernel
    Greg> development by posting and defending their own code to lkml.
    Greg> I thought IBM knew better than that...

Agreed.  But let's not get sidetracked on that internal IBM issue.
The ehca developers have assured me that they can and will participate
in the thread reviewing their driver.  It seems like it's better for
me to help them work around their internal problems by acting as a
proxy, than for me to delay merging their driver just because someone
in IBM management is clueless.

 - R.
