Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262984AbUKTPnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbUKTPnu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 10:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbUKTPnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 10:43:50 -0500
Received: from ozlabs.org ([203.10.76.45]:50838 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262984AbUKTPns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 10:43:48 -0500
Date: Sun, 21 Nov 2004 02:38:49 +1100
From: Anton Blanchard <anton@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, Adam Litke <agl@us.ibm.com>,
       Andy Whitworth <apw@shadowen.org>
Subject: Re: [RFC] Consolidate lots of hugepage code
Message-ID: <20041120153849.GB11932@krispykreme.ozlabs.ibm.com>
References: <20041029033708.GF12247@zax> <20041029034817.GY12934@holomorphy.com> <20041107172030.GA16976@krispykreme.ozlabs.ibm.com> <20041107192024.GM2890@holomorphy.com> <20041107193007.GC16976@krispykreme.ozlabs.ibm.com> <20041107210943.GN2890@holomorphy.com> <20041107212212.GD16976@krispykreme.ozlabs.ibm.com> <20041107224948.GO2890@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041107224948.GO2890@holomorphy.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi wli,

Any progress on this? If not Id like to suggest we get Davids patch into
-mm.

Anton

> Sorry, I don't get complete bugreports myself. If you care to try to
> actually fix something (it's doubtful you yourself are the culprit) I'm
> still trying to reproduce it myself with long-running database tests.
> It's reliably reproducible on the reporters' machines.
> 
> The particular bug is only one piece of evidence. Just asking basic
> questions about what was done for architecture code reveals that
> all this "development" is not paying proper attention to architecture
> code. I merely insist that development toward the end of stabilization
> occur prior to that for large feature work.
> 
> And frankly, I'm rather unimpressed with the gravity of the proposed
> featurework, particularly in comparison to the stability requirements
> of users on typical production systems.
> 
> Nor am I impressed with the quality. The patch presentations have been
> messy, the audits (as mentioned above) incomplete, the benefits not
> clearly demonstrated, and the code itself not so pretty. Just
> respinning the patches so they're properly incremental and the code
> somewhat cleaner (e.g. some recent one nested tabs 5 deep or so)
> would already remedy a large number of the issues with the featurework.
> Once arranged that way the audits' incompleteness can be dealt with by
> those with the fortitude to thoroughly audit and/or prior architecture
> knowledge to correct the patches for arches they don't deal with properly.
> 
> 
> -- wli
