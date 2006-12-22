Return-Path: <linux-kernel-owner+w=401wt.eu-S1945966AbWLVHTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945966AbWLVHTq (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 02:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945965AbWLVHTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 02:19:44 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:15148 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945966AbWLVHTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 02:19:42 -0500
Message-ID: <458B8704.6060607@chelsio.com>
Date: Thu, 21 Dec 2006 23:19:32 -0800
From: Divy Le Ray <divy@chelsio.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH 0/10] cxgb3: Chelsio T3 1G/10G ethernet device driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Dec 2006 07:19:35.0437 (UTC) FILETIME=[888ACBD0:01C72599]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

I resubmit the patch supporting the latest Chelsio T3 adapter.
It incorporates Arjan's feedbacks:
- remove unnecessary ifdefs
- updates the pci ressource managment
- add flush after register write.

It is built against Linus'tree.

A corresponding monolithic patch is available at this URL:
http://service.chelsio.com/kernel.org/cxgb3.patch.bz2

This driver is required by the Chelsio T3 RDMA driver
which was updated on 12/20/2006.

Cheers,
Divy
