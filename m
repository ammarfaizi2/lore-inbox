Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266157AbUHYVjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266157AbUHYVjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 17:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbUHYVjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 17:39:03 -0400
Received: from marasystems.com ([213.150.153.194]:13457 "EHLO
	filer.marasystems.com") by vger.kernel.org with ESMTP
	id S266157AbUHYVfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 17:35:38 -0400
Date: Wed, 25 Aug 2004 23:35:05 +0200 (CEST)
From: Henrik Nordstrom <hno@marasystems.com>
To: Harald Welte <laforge@netfilter.org>
cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc1
In-Reply-To: <20040825203206.GS5824@sunbeam.de.gnumonks.org>
Message-ID: <Pine.LNX.4.61.0408252334230.28603@filer.marasystems.com>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
 <412CDFEE.1010505@triplehelix.org> <20040825203206.GS5824@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004, Harald Welte wrote:

> The 'problem' is that we try to get a readlock while we're already
> protected under a write lock.
>
> Please see the following [quite trivial, but yet untested] patch:
>
> EXPORT_SYMBOL(ip_nat_used_tuple);
> +EXPORT_SYMBOL(ip_nat_find_helper);

Why this new exported symbol?

Regards
Henrik
