Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWFBUB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWFBUB2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWFBUB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:01:28 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:48259 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1750868AbWFBUB1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:01:27 -0400
Date: Fri, 2 Jun 2006 13:02:44 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Jens Axboe <axboe@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, torvalds@osdl.org,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Jeff Garzik <jeff@garzik.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       Chris Wedgewood <reviews@ml.cw.f00f.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Mark Lord <liml@rtr.ca>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       stable@kernel.org, alan@lxorguk.ukuu.org.uk,
       Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [stable] Re: [PATCH 07/11] the latest consensus libata resume fix
Message-ID: <20060602200244.GS18769@moss.sous-sol.org>
References: <20060602194618.482948000@sous-sol.org> <20060602194742.420464000@sous-sol.org> <20060602195046.GO4400@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060602195046.GO4400@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jens Axboe (axboe@suse.de) wrote:
> I'm not against the patch as such, but last I checked 2.6.16 actually
> worked ok. The timer fixes in 2.6.17-rc is what apparently got the
> resume breaking.
> 
> So unless there's a bug report on 2.6.16.x for this, then it's a little
> against the -stable rules to add it.

We did get a report that this fix was needed, but I'm not 100% which
kernel base the report was against.  Marcel, were you testing on a 2.6.16
base, or 2.6.17-rc?

thanks,
-chris
