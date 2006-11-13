Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755198AbWKMQkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198AbWKMQkG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755194AbWKMQkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:40:05 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:56219 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1755198AbWKMQkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:40:01 -0500
X-IronPort-AV: i="4.09,418,1157353200"; 
   d="scan'208"; a="2088509:sNHT5818718970"
To: Paul Mackerras <paulus@samba.org>
Cc: Christoph Raisch <RAISCH@de.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, openib-general@openib.org,
       openib-general-bounces@openib.org
Subject: Re: [openib-general] [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page mapping in 64k page mode
X-Message-Flag: Warning: May contain useful information
References: <adaodrgb7uq.fsf@cisco.com>
	<OF75FFAC00.E43450CA-ONC1257222.002A402A-C1257222.002AB9BD@de.ibm.com>
	<17748.15442.906060.210242@cargo.ozlabs.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 13 Nov 2006 08:39:58 -0800
In-Reply-To: <17748.15442.906060.210242@cargo.ozlabs.ibm.com> (Paul Mackerras's message of "Fri, 10 Nov 2006 19:46:10 +1100")
Message-ID: <adahcx35mht.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Nov 2006 16:39:58.0581 (UTC) FILETIME=[5B632A50:01C70742]
Authentication-Results: sj-dkim-1; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > The patch is needed. We've seen it on the real system. We did fix it on the
 > > real system.
 > 
 > I disagree that the ioremap change is needed.

Hmm... Paul, what you say makes sense and is what I would have
thought, but Christoph says that the unpatched code really fails on a
real system.  So I'm still confused.

I think I'll merge this with a fat comment, with the hope that we can
drop it ASAP once everyone agrees on what's going on.

 - R.
