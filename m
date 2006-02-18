Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWBRMUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWBRMUQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWBRMUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:20:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21937 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751180AbWBRMUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:20:14 -0500
Date: Sat, 18 Feb 2006 12:20:11 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Greg KH <greg@kroah.com>, Roland Dreier <rolandd@cisco.com>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org, SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com,
       HNGUYEN@de.ibm.com, MEDER@de.ibm.com
Subject: Re: [PATCH 02/22] Firmware interface code for IB device.
Message-ID: <20060218122011.GE911@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <rdreier@cisco.com>, Greg KH <greg@kroah.com>,
	Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc64-dev@ozlabs.org, openib-general@openib.org,
	SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
	MEDER@de.ibm.com
References: <20060218005532.13620.79663.stgit@localhost.localdomain> <20060218005707.13620.20538.stgit@localhost.localdomain> <20060218015808.GB17653@kroah.com> <aday809bewn.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aday809bewn.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 06:04:56PM -0800, Roland Dreier wrote:
>     Greg> Roland, your comments are fine, but what about the original
>     Greg> author's descriptions of what each patch are?
> 
> This is actually me breaking up a giant driver into pieces small
> enough to post to lkml without hitting the 100 KB limit.
> 
> This is just an RFC -- I assume the driver is going to get merged in
> the end as one big git changeset with a changelog like "add driver for
> IBM eHCA InfiniBand adapters".
> 
>     Greg> Come on, IBM allows developers to post code to lkml, just
>     Greg> look at the archives for proof.  For them to use a proxy
>     Greg> like this is very strange, and also, there is no
>     Greg> Signed-off-by: record from the original authors, which is
>     Greg> not ok.
> 
> Well, the eHCA guys tell me that they can't post patches to lkml.

Then they lie.  And not posting to lkml is a good reason not to merge
an otherwise perfect driver.  (which this one is far from)

