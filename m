Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269386AbUI3Tjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269386AbUI3Tjs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 15:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269453AbUI3Tjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 15:39:48 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:46290 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S269386AbUI3Tjq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:39:46 -0400
Date: Thu, 30 Sep 2004 21:39:45 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Christian <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ip_nat_helper  / ip_conntrack_core issues with recent 2.6 kernels
Message-ID: <20040930193945.GA10777@janus>
References: <4137B825.8080801@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4137B825.8080801@g-house.de>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 02:17:41AM +0200, Christian wrote:
> hi,
> 
> yesterday i had to downgrade from 2.6.8-rc1-mm1 to 2.6.9-rc1 (because of 
...
> now i'm using 2.6.9-rc1-bk8 and i'm getting these messages, again when 
> trying to use ftp:
> 
> NF_IP_ASSERT: net/ipv4/netfilter/ip_conntrack_core.c:658(init_conntrack)

I see that one too in 2.6.9-rc2:
Sep 30 21:33:47 iapetus kernel: NF_IP_ASSERT: net/ipv4/netfilter/ip_conntrack_core.c:658(init_conntrack)
Sep 30 21:34:30 iapetus last message repeated 3 times
Sep 30 21:35:38 iapetus last message repeated 4 times

while lftp'ing to get -rc3. No problems doing so.


-- 
Frank
