Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbWEaTYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbWEaTYp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 15:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbWEaTYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 15:24:45 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:49724 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S965117AbWEaTYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 15:24:43 -0400
X-IronPort-AV: i="4.05,194,1146466800"; 
   d="scan'208"; a="323919244:sNHT29247340"
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iWARP Connection Manager.
X-Message-Flag: Warning: May contain useful information
References: <20060531182650.3308.81538.stgit@stevo-desktop>
	<20060531182652.3308.1244.stgit@stevo-desktop>
	<20060531114059.704ef1f1@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 31 May 2006 12:24:42 -0700
In-Reply-To: <20060531114059.704ef1f1@localhost.localdomain> (Stephen Hemminger's message of "Wed, 31 May 2006 11:40:59 -0700")
Message-ID: <ada3beqyp39.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 31 May 2006 19:24:42.0321 (UTC) FILETIME=[DDFBB410:01C684E7]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	cm_id_priv = kzalloc(sizeof *cm_id_priv, GFP_KERNEL);

> Please put paren's after sizeof, it is not required by C but it
> is easier to read.

I disagree -- I hate seeing sizeof look like a function call.

 - R.
