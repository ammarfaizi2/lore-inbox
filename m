Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWCIX16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWCIX16 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbWCIX16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:27:58 -0500
Received: from mx.pathscale.com ([64.160.42.68]:62085 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751968AbWCIX16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:27:58 -0500
Subject: Re: [PATCH 7 of 20] ipath - misc driver support code
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <aday7zjfc36.fsf@cisco.com>
References: <2f16f504dd4b98c2ce7c.1141922820@localhost.localdomain>
	 <aday7zjfc36.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 09 Mar 2006 15:27:57 -0800
Message-Id: <1141946877.10693.34.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 15:11 -0800, Roland Dreier wrote:
>  > +static unsigned handle_frequent_errors(struct ipath_devdata *dd,
>  > +				       ipath_err_t errs, char msg[512],
>  > +				       int *noprint)

> Could this be replaced by printk_ratelimit()?

I looked into doing that a few weeks ago, and it really didn't look like
a good fit at all.

	<b

