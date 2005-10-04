Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbVJEQhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbVJEQhs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbVJEQhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:37:47 -0400
Received: from mail.collax.com ([213.164.67.137]:41119 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1030237AbVJEQhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:37:46 -0400
Message-ID: <4342B575.9090709@trash.net>
Date: Tue, 04 Oct 2005 19:01:41 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Harald Welte <laforge@netfilter.org>, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
References: <432EF0C5.5090908@cosmosbay.com>	<Pine.LNX.4.61.0509280219110.25500@filer.marasystems.com>	<20050928083240.GP4168@sunbeam.de.gnumonks.org> <200509281037.03185.ak@suse.de>
In-Reply-To: <200509281037.03185.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> In a sense it's even getting worse: For example us losing the CONFIG
> option to disable local conntrack (Patrick has disabled it some time ago 
> without even a comment why he did it) has a really bad impact in some cases.

It was necessary to correctly handle locally generated ICMP errors.
