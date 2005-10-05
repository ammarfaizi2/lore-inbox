Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbVJEQ53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbVJEQ53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbVJEQ52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:57:28 -0400
Received: from ns2.suse.de ([195.135.220.15]:39313 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030250AbVJEQ51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:57:27 -0400
From: Andi Kleen <ak@suse.de>
To: Patrick McHardy <kaber@trash.net>
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
Date: Wed, 5 Oct 2005 18:53:31 +0200
User-Agent: KMail/1.8.2
Cc: Harald Welte <laforge@netfilter.org>, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       Henrik Nordstrom <hno@marasystems.com>
References: <432EF0C5.5090908@cosmosbay.com> <200509281037.03185.ak@suse.de> <4342B575.9090709@trash.net>
In-Reply-To: <4342B575.9090709@trash.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510051853.32196.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 October 2005 19:01, Patrick McHardy wrote:
> Andi Kleen wrote:
> > In a sense it's even getting worse: For example us losing the CONFIG
> > option to disable local conntrack (Patrick has disabled it some time ago
> > without even a comment why he did it) has a really bad impact in some
> > cases.
>
> It was necessary to correctly handle locally generated ICMP errors.

Well you most likely wrecked local performance then when it's enabled.

-Andi

