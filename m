Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937084AbWLDQYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937084AbWLDQYg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937085AbWLDQYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:24:35 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:51572 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937084AbWLDQYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:24:34 -0500
Subject: Re: [PATCH  v2 00/13] 2.6.20 Chelsio T3 RDMA Driver
From: Steve Wise <swise@opengridcomputing.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Francois Romieu <romieu@fr.zoreil.com>, rdreier@cisco.com,
       netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <4572194F.8060309@osdl.org>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int>
	 <20061202231329.GA10719@electric-eye.fr.zoreil.com>
	 <4572194F.8060309@osdl.org>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 10:24:34 -0600
Message-Id: <1165249474.32724.30.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>     
> >
> > I understood that Stephen expressed some doubts regarding the inclusion
> > of TOE enabled features.
> >
> > Was his point addressed ?
> >
> >   
> 
> My comments were about different hardware.


Just to clarify:  

Stephen is working on the Chelsio T2 HW driver.  

The drivers Divy and I are submitting are for the new Chelsio T3
hardware.  Two drivers are being submitted:  The Ethernet driver
(submitted by Divy) and the RDMA driver (submitted by me) which requires
the Ethernet driver.  The RDMA driver will live in
drivers/infiniband/hw/cxgb3 and the Ethernet driver will live in
drivers/net/cxgb3.


Steve.




