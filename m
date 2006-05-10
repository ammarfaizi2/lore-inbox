Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWEJFdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWEJFdB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 01:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWEJFdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 01:33:01 -0400
Received: from [194.90.237.34] ([194.90.237.34]:61487 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S964819AbWEJFdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 01:33:00 -0400
Date: Wed, 10 May 2006 08:33:41 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Shirley Ma <xma@us.ibm.com>
Cc: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Heiko J Schick <info@schihei.de>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Marcus Eder <MEDER@de.ibm.com>, openib-general@openib.org,
       openib-general-bounces@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Roland Dreier <rdreier@cisco.com>
Subject: Re: [openib-general] Re: [PATCH 07/16] ehca: interrupt handling	routines
Message-ID: <20060510053341.GI22825@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060509202041.GB24713@mellanox.co.il> <OFD1053717.15B4F49A-ON87257169.007531E1-88257169.007AD29E@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD1053717.15B4F49A-ON87257169.007531E1-88257169.007AD29E@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 10 May 2006 05:36:41.0015 (UTC) FILETIME=[B6F14470:01C673F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Shirley Ma <xma@us.ibm.com>:
> Subject: Re: [openib-general] Re: [PATCH 07/16] ehca: interrupt handling?routines
> 
> 
> "Michael S. Tsirkin" <mst@mellanox.co.il> wrote on 05/09/2006 01:20:41 PM:
> 
> > Quoting r. Shirley Ma <xma@us.ibm.com>:
> > > My understanding is NAPI handle interrutps CQ callbacks on the same CPU.
> >
> > My understanding is NAPI disables interrupts under high RX load. No?
> 
> Yes, NAPI disables the interrupts based on the weight. In IPoIB case, it doesn't
> send out the next completion notification under heavy loading.
> The similiar CQ polling is still in NAPI on same CPU, but it's not a callback
> anymore.

Sorry, same CPU as what?

-- 
MST
