Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWIAVD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWIAVD6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 17:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWIAVD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 17:03:58 -0400
Received: from mx.pathscale.com ([64.160.42.68]:9860 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750851AbWIAVD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 17:03:57 -0400
Subject: Re: [openib-general] 2.6.18-rc5-mm1:
	drivers/infiniband/hw/amso1100/c2.c compile error
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, Adrian Bunk <bunk@stusta.de>,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <adaveo7gv69.fsf@cisco.com>
References: <20060901015818.42767813.akpm@osdl.org>
	 <20060901160023.GB18276@stusta.de> <20060901101340.962150cb.akpm@osdl.org>
	 <adak64nij8f.fsf@cisco.com> <20060901112312.5ff0dd8d.akpm@osdl.org>
	 <ada8xl3ics4.fsf@cisco.com>
	 <1157143527.20958.8.camel@chalcedony.pathscale.com>
	 <adaveo7gv69.fsf@cisco.com>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 14:03:57 -0700
Message-Id: <1157144637.20958.15.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 13:59 -0700, Roland Dreier wrote:

> No, quite the opposite.  I'm arguing that the wrappers in mthca do
> legitimately belong in a device driver, since they encapsulate
> device-specific knowledge about what serialization suffices when an
> atomic __raw_writeq() is not available.

Yes, I figured that out from some later messages.  I think we're
violently in agreement, in that case.

	<b


-- 
VGER BF report: H 0
