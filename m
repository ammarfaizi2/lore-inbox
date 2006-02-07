Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWBGX3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWBGX3Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWBGX3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:29:25 -0500
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:17090 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030264AbWBGX3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:29:25 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [rfc][patch] sched: remove smpnice
Date: Wed, 8 Feb 2006 10:29:25 +1100
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, npiggin@suse.de, mingo@elte.hu,
       rostedt@goodmis.org, suresh.b.siddha@intel.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Martin Bligh <mbligh@google.com>
References: <20060207142828.GA20930@wotan.suse.de> <20060207141525.19d2b1be.akpm@osdl.org> <43E92B2B.2060105@bigpond.net.au>
In-Reply-To: <43E92B2B.2060105@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602081029.25530.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006 10:20 am, Peter Williams wrote:
> Finally, the issue of whether the unacceptable side effects with
> hackbench described by Nick are still present when my patch is applied
> on top of Con's patch needs to be tested.  I think that this is the only
> issue that would prevent my patch going into the main line as the other
> issues have been resolved.

Since whatever we do is a compromise, I vote we fasttrack Peter's patches. See 
if they fix the hackbench regression and take it from there. They have had 
reasonable testing in -mm, and the last changes he made did not significantly 
change the code but fixed balancing decisions. 

Cheers,
Con
