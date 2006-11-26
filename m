Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757945AbWKZUGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757945AbWKZUGg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 15:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757946AbWKZUGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 15:06:36 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:36152 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1757945AbWKZUGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 15:06:35 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, tom@opengridcomputing.com,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] Avoid truncating to 'long' in ALIGN() macro
X-Message-Flag: Warning: May contain useful information
References: <adazmag5bk1.fsf@cisco.com>
	<20061124.220746.57445336.davem@davemloft.net>
	<adaodqv5e5l.fsf@cisco.com>
	<20061125.150500.14841768.davem@davemloft.net>
	<adak61j5djh.fsf@cisco.com> <20061125164118.de53d1cf.akpm@osdl.org>
	<ada64d23ty8.fsf@cisco.com> <20061126111703.33247a84.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 26 Nov 2006 12:06:33 -0800
In-Reply-To: <20061126111703.33247a84.akpm@osdl.org> (Andrew Morton's message of "Sun, 26 Nov 2006 11:17:03 -0800")
Message-ID: <adau00m2cs6.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Nov 2006 20:06:33.0967 (UTC) FILETIME=[5EFBB7F0:01C71196]
Authentication-Results: sj-dkim-1; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I'd be inclined to merge it for 2.6.19.  Is everyone OK with it?

I'm OK with that -- your previous email made me thing you didn't want
to, but I think the risks are rather low, and there's a least a chance
that we'll fix some obscure regression.
