Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbWCFU15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWCFU15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 15:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWCFU14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 15:27:56 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:38111 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750993AbWCFU1z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 15:27:55 -0500
In-Reply-To: <54AD0F12E08D1541B826BE97C98F99F12FBF33@NT-SJCA-0751.brcm.ad.broadcom.com>
To: "Caitlin Bestler" <caitlinb@broadcom.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>, netdev@vger.kernel.org
MIME-Version: 1.0
Subject: RE: RFC: move SDP from AF_INET_SDP to IPPROTO_SDP
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF8F668698.3BC5B375-ON88257129.00701FC1-88257129.007069DF@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Mon, 6 Mar 2006 12:31:33 -0800
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.53HF654 | July 22, 2005) at
 03/06/2006 13:31:34,
	Serialize complete at 03/06/2006 13:31:34
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IPPROTO_* should match the protocol field on the wire, which
I gather isn't different. And I'm assuming there is no standard API
defined already...

What about using a socket option?

                                        +-DLS

