Return-Path: <linux-kernel-owner+w=401wt.eu-S1422695AbXAMPdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422695AbXAMPdO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 10:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422691AbXAMPdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 10:33:14 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:21216 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422695AbXAMPdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 10:33:13 -0500
X-IronPort-AV: i="4.13,183,1167638400"; 
   d="scan'208"; a="356103804:sNHT47175272"
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Miles Lane <miles.lane@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       avi@qumranet.com, kvm-devel@lists.sourceforge.net,
       Russell King <rmk+lkml@arm.linux.org.uk>, vojtech@suse.cz,
       greg@kroah.com, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.20-rc5: known regressions with patches
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
	<20070113071412.GH7469@stusta.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Sat, 13 Jan 2007 07:32:46 -0800
In-Reply-To: <20070113071412.GH7469@stusta.de> (Adrian Bunk's message of "Sat, 13 Jan 2007 08:14:12 +0100")
Message-ID: <adaps9j54dd.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Jan 2007 15:32:47.0113 (UTC) FILETIME=[13A4B790:01C73728]
Authentication-Results: sj-dkim-1; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > This email lists some known regressions in 2.6.20-rc5 compared to 2.6.19
 > with patches available.

 > Subject    : KVM: guest crash
 > References : http://lkml.org/lkml/2007/1/8/163
 > Submitter  : Roland Dreier <rdreier@cisco.com>
 > Handled-By : Avi Kivity <avi@qumranet.com>
 > Patch      : http://lkml.org/lkml/2007/1/9/280
 > Status     : patch available

This is not a regression from 2.6.19, since kvm did not exist in
2.6.19.  In any case akpm has the patch and plans to merge it for
2.6.20 so I don't think anyone has to worry about this one.

 - R.
