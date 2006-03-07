Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWCGVxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWCGVxP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWCGVxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:53:15 -0500
Received: from [194.90.237.34] ([194.90.237.34]:30785 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S964777AbWCGVxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:53:14 -0500
Date: Tue, 7 Mar 2006 23:53:22 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Matt Leininger <mlleinin@hpcn.ca.sandia.gov>, Shirley Ma <xma@us.ibm.com>,
       netdev@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [openib-general] Re: TSO and IPoIB performance degradation
Message-ID: <20060307215322.GD20703@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <OF336D72E6.999D2A30-ON8725712A.00117C92-8825712A.00116629@us.ibm.com> <1141767891.6119.903.camel@localhost> <20060307134907.733d3d27@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307134907.733d3d27@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 07 Mar 2006 21:55:32.0781 (UTC) FILETIME=[DB5D8DD0:01C64231]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Stephen Hemminger <shemminger@osdl.org>:
> Is IB using NAPI or just doing netif_rx()?

No, IPoIB doesn't use NAPI.

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
