Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031183AbWKUQsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031183AbWKUQsA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 11:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031212AbWKUQr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 11:47:59 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:10847 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1031183AbWKUQr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 11:47:58 -0500
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Cc: rolandd@cisco.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, raisch@de.ibm.com
Subject: Re: [PATCH 2.6.19] ehca: bug fix: use wqe offset instead wqe address to determine pending work requests
X-Message-Flag: Warning: May contain useful information
References: <200611202354.13030.hnguyen@linux.vnet.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 21 Nov 2006 08:47:52 -0800
In-Reply-To: <200611202354.13030.hnguyen@linux.vnet.ibm.com> (Hoang-Nam Nguyen's message of "Mon, 20 Nov 2006 23:54:12 +0100")
Message-ID: <adaslgcg30n.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Nov 2006 16:47:53.0540 (UTC) FILETIME=[C9CA2840:01C70D8C]
Authentication-Results: sj-dkim-5; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim5002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Umm, it's really late to merge things for 2.6.19.  How severe is this
bug?  Why has it not been found until now if it causing crashes?

 - R.
