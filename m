Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267946AbUHPUiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267946AbUHPUiE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 16:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267947AbUHPUiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 16:38:04 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:10204 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267946AbUHPUiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 16:38:02 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P1
From: Lee Revell <rlrevell@joe-job.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <412108E0.4090300@namesys.com>
References: <1092622121.867.109.camel@krustophenia.net>
	 <20040816023655.GA8746@elte.hu> <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu>  <412108E0.4090300@namesys.com>
Content-Type: text/plain
Message-Id: <1092688732.13981.28.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 16:38:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 15:20, Hans Reiser wrote:
> Ingo Molnar wrote:
> >
> >i took a quick look and the reiserfs locking rules in that place do not
> >seem to be easily fixable - this is the tree-lookup code which i suspect
> >cannot be preempted. The reiser journalling code also makes use of the
> >big kernel lock. I'd suggest reporting this to the reiserfs folks
> >
> the fix to reiserfs doing single threaded balancing/searching is called 
> reiser4;-)  It was not a trivial fix.  It is however released.
> 

When will reiser4 will be in the stock kernel?

Lee 

