Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbWEJWGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbWEJWGT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 18:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWEJWGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 18:06:19 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:33457 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S965036AbWEJWGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 18:06:17 -0400
X-IronPort-AV: i="4.05,111,1146466800"; 
   d="scan'208"; a="1803991068:sNHT2687588990"
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Brice Goglin <bgoglin@myri.com>, netdev@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "Andrew J. Gallatin" <gallatin@myri.com>, <brice@myri.com>
Subject: Re: [PATCH 4/6] myri10ge - First half of the driver
X-Message-Flag: Warning: May contain useful information
References: <446259A0.8050504@myri.com>
	<Pine.GSO.4.44.0605101438410.498-100000@adel.myri.com>
	<20060510150112.46a732d4@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 10 May 2006 15:06:11 -0700
In-Reply-To: <20060510150112.46a732d4@localhost.localdomain> (Stephen Hemminger's message of "Wed, 10 May 2006 15:01:12 -0700")
Message-ID: <ada8xp97cx8.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 May 2006 22:06:11.0775 (UTC) FILETIME=[F2AC4CF0:01C6747D]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Stephen> Splitting it in half, might help email restrictions, but
    Stephen> it kills future users of 'git bisect' who expect to have
    Stephen> every kernel buildable.

Not really, since the makefile/kconfig stuff comes in a later patch.

But yes, it is cleaner to have drivers go in in sane pieces.

 - R.
