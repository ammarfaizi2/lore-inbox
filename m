Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422880AbWHYTvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422880AbWHYTvF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422865AbWHYTvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:51:05 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:50207 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1422880AbWHYTvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:51:02 -0400
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11 of 23] IB/ipath - add new minor device to allow sending of diag packets
X-Message-Flag: Warning: May contain useful information
References: <8743e6ee09c51e799f0f.1156530276@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 25 Aug 2006 12:50:58 -0700
In-Reply-To: <8743e6ee09c51e799f0f.1156530276@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Fri, 25 Aug 2006 11:24:36 -0700")
Message-ID: <ada7j0wtx0d.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Aug 2006 19:51:01.0084 (UTC) FILETIME=[CA8651C0:01C6C87F]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +	if (ret < 0) {
 > +		printk(KERN_ERR IPATH_DRV_NAME ": Unable to create "
 > +		       "diag data device: error %d\n", -ret);
 > +		goto bail_ipathfs;
 > +	}
 > + 

The last line adds trailing whitespace, which git complains about.
When patchbombing, can you run your patches through "git apply --check
--whitespace=error-all" or the equivalent?

Thanks,
  Roland
