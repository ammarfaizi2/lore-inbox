Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWEOPot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWEOPot (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWEOPot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:44:49 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:16413 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1751453AbWEOPos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:44:48 -0400
X-IronPort-AV: i="4.05,130,1146466800"; 
   d="scan'208"; a="322273517:sNHT42718388"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0 of 53] ipath driver updates for 2.6.17-rc4
X-Message-Flag: Warning: May contain useful information
References: <patchbomb.1147477365@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 15 May 2006 08:44:46 -0700
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Fri, 12 May 2006 16:42:45 -0700")
Message-ID: <adau07ruwb5.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 May 2006 15:44:47.0799 (UTC) FILETIME=[7ED36C70:01C67836]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Umm... dumping a 53 patch series into the kernel at this stage in the
release cycle isn't going to work.  You need to sort out the patches
that need to go into 2.6.17 from patches that can wait.  For example,
a 1500+ line patch to factor out common code is clearly not
appropriate now.  Pretty much the only patches that should be going in
now are changes that fix crashes or other serious bugs.

(You can send both sets of patches at the same time -- just let me
which ones are for 2.6.17 and which ones can be queued for 2.6.18)

I have some more specific comments in reply to individual patches,
although I didn't try to review all 53.

 - R.
