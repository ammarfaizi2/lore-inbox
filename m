Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUHSJ4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUHSJ4V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbUHSJ4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:56:20 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:55168 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264795AbUHSJ4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:56:09 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P3
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Charbonnel <thomas@undata.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040819115438.12306093@mango.fruits.de>
References: <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>
	 <20040818141231.4bd5ff9d@mango.fruits.de> <20040818122703.GA17301@elte.hu>
	 <20040819115438.12306093@mango.fruits.de>
Content-Type: text/plain
Message-Id: <1092909443.8432.141.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 19 Aug 2004 05:57:23 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-19 at 05:54, Florian Schmidt wrote:
> On Wed, 18 Aug 2004 14:27:03 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > * Florian Schmidt <mista.tapas@gmx.net> wrote:
> > 
> > > Hi, it applied against 2.6.8.1 with some offsets and some buzz [?].
> > > Well anyways it compiled fine and the copy_page_range latency is
> > > gone.. Now i also see the extracty entropy thing, too..
> > 
> > could you try the attached patch that changes SHA_CODE_SIZE to 3 -
> > does this reduce the latency caused by extract_entropy?
> 
> sorry, my box got fsck'ed. rebuilding system now. will be a day before i
> can resume testing..
> 

By any chance did you try the hack I posted to disable the random
driver?  I suspect that had subtle effects that hosed my machine.  I did
not have to rebuild it from scratch, but it was close.  Things would
break and then start working again after a reboot or two for no reason.

Lee

