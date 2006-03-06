Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWCFTpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWCFTpZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbWCFTpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:45:24 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:46987 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750998AbWCFTpY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:45:24 -0500
In-Reply-To: <20060306190636.GA14849@mellanox.co.il>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
MIME-Version: 1.0
Subject: Re: RFC: move SDP from AF_INET_SDP to IPPROTO_SDP
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFB3CB1E4D.355F7555-ON88257129.006C1001-88257129.006C836D@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Mon, 6 Mar 2006 11:48:53 -0800
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.53HF654 | July 22, 2005) at
 03/06/2006 12:49:03,
	Serialize complete at 03/06/2006 12:49:03
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know any details about SDP, but if there are no differences at the
protocol layer, then neither the address family nor the protocol is
appropriate. If it's just an API change, the socket type is the right
selector. So, maybe SOCK_DIRECT to go along with SOCK_STREAM,
SOCK_DGRAM, etc.
                                        +-DLS

