Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162009AbWKOWfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162009AbWKOWfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 17:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162012AbWKOWfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 17:35:21 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:57754 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1162009AbWKOWfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 17:35:19 -0500
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	<20061114.190036.30187059.davem@davemloft.net>
	<Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
	<20061114.192117.112621278.davem@davemloft.net>
	<s5hbqn99f2v.wl%tiwai@suse.de> <20061115112014.54de5b2c@freekitty>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 15 Nov 2006 14:35:16 -0800
In-Reply-To: <20061115112014.54de5b2c@freekitty> (Stephen Hemminger's message of "Wed, 15 Nov 2006 11:20:14 -0800")
Message-ID: <adahcx0wd7f.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Nov 2006 22:35:16.0833 (UTC) FILETIME=[52E1C510:01C70906]
Authentication-Results: sj-dkim-1; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > A whitelist is an awkward solution, the problem is the number of
 > chipsets available with MSI will continue to grow. And the assumption
 > is that after Microsoft OS supports MSI, that newer chipsets will work.

Maybe a whitelist for older systems and then enable everything after a
DMI cutoff date by default?  Doesn't work on non-PC stuff though...

 - R.
