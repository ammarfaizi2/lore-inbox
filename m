Return-Path: <linux-kernel-owner+w=401wt.eu-S1751708AbXAUWGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbXAUWGN (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 17:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbXAUWGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 17:06:13 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:27674 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbXAUWGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 17:06:12 -0500
X-IronPort-AV: i="4.13,217,1167638400"; 
   d="scan'208"; a="357159758:sNHT43668820"
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org,
       raisch@de.ibm.com
Subject: Re: [PATCH 2.6.20 1/2] ehca: ehca_cq.c: fix unproper use of yield within spinlock context
X-Message-Flag: Warning: May contain useful information
References: <200701192250.10765.hnguyen@linux.vnet.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 21 Jan 2007 14:06:09 -0800
In-Reply-To: <200701192250.10765.hnguyen@linux.vnet.ibm.com> (Hoang-Nam Nguyen's message of "Fri, 19 Jan 2007 22:50:10 +0100")
Message-ID: <ada4pqkrq5q.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Jan 2007 22:06:09.0300 (UTC) FILETIME=[5AF2A540:01C73DA8]
Authentication-Results: sj-dkim-7; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim7002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very minor but

 > Signed-off-by Hoang-Nam Nguyen <hnguyen@de.ibm.com>

should be

Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>

(':' after the "-by")

Anyway, queued for 2.6.20, thanks.

 - R.
