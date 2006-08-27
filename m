Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWH0W0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWH0W0A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 18:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWH0W0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 18:26:00 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:53319 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1751218AbWH0WZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 18:25:59 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Robert Walsh <rjwalsh@pathscale.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 22 of 23] IB/ipath - print warning if LID not acquired within one minute
X-Message-Flag: Warning: May contain useful information
References: <44EF6053.4010006@pathscale.com>
	<20060826193126.GF21168@mellanox.co.il>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 27 Aug 2006 15:25:56 -0700
Message-ID: <adalkp9rf2j.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 27 Aug 2006 22:25:58.0153 (UTC) FILETIME=[C4D5F790:01C6CA27]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Michael> Looks like your devices are all single-port. With a multi
    Michael> port device it is quite common to have one port down.

My reading of the patch is that it warns if the link is up physically
but does not come up logically.  Which would still be reasonable for a
multi-port device.

But I am still wondering about when this is really useful.

 - R.
