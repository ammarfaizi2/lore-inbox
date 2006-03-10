Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751844AbWCJTXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbWCJTXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 14:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbWCJTXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 14:23:33 -0500
Received: from mx.pathscale.com ([64.160.42.68]:60131 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751844AbWCJTXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 14:23:33 -0500
Subject: Re: [PATCH 7 of 20] ipath - misc driver support code
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <adaveundwcd.fsf@cisco.com>
References: <2f16f504dd4b98c2ce7c.1141922820@localhost.localdomain>
	 <adau0a7fbzf.fsf@cisco.com>
	 <1141946942.10693.36.camel@serpentine.pathscale.com>
	 <adaveundwcd.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 10 Mar 2006 11:23:28 -0800
Message-Id: <1142018608.29925.96.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 15:36 -0800, Roland Dreier wrote:

> If Via behaves like
> Intel and reorders writes, but ipath_unordered_wc() returns false,
> then won't your driver break in a subtle way?

No, it'll issue lots of error messages, because the chip will detect the
bad access patterns and interrupt us.

	<b

