Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936141AbWK3CWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936141AbWK3CWh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 21:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936139AbWK3CWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 21:22:37 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:51207
	"HELO linuxace.com") by vger.kernel.org with SMTP id S936141AbWK3CWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 21:22:36 -0500
Date: Wed, 29 Nov 2006 18:22:36 -0800
From: Phil Oester <kernel@linuxace.com>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org
Subject: Re: Linux 2.6.19
Message-ID: <20061130022236.GA1401@linuxace.com>
References: <20061129151111.6bd440f9.rdunlap@xenotime.net> <20061130005631.GA3896@yggdrasil.localdomain> <20061130014904.GA1405@linuxace.com> <20061129.181537.38322733.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129.181537.38322733.davem@davemloft.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 06:15:37PM -0800, David Miller wrote:
> In fact it does, the NDISC code is using MAX_HEADER incorrectly.  It
> needs to explicitly allocate space for the struct ipv6hdr in 'len'.
> Luckily the TCP ipv6 code was doing it right.
> 
> What a horrible bug, this patch should fix it.  Let me know
> if it doesn't, thanks:

Yes, that fixes it up for me, thanks.

Phil
