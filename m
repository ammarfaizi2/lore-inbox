Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269791AbUICM4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269791AbUICM4b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269785AbUICM4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:56:30 -0400
Received: from [64.147.162.83] ([64.147.162.83]:22988 "EHLO
	thunderbolt.ipaska.net") by vger.kernel.org with ESMTP
	id S269666AbUICMyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:54:14 -0400
Date: Fri, 3 Sep 2004 22:52:59 +1000
From: Luke Yelavich <luke@audioslack.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, free78@tin.it
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
Message-ID: <20040903125259.GA13593@luke-laptop.yelavich.home>
References: <20040902221402.GA29434@elte.hu> <1094171082.19760.7.camel@krustophenia.net> <1094181447.4815.6.camel@orbiter> <1094192788.19760.47.camel@krustophenia.net> <20040903063658.GA11801@elte.hu> <1094194157.19760.71.camel@krustophenia.net> <20040903070500.GB13100@elte.hu> <1094197233.19760.115.camel@krustophenia.net> <20040903080930.GA30814@luke-laptop.yelavich.home> <1094199195.19760.136.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094199195.19760.136.camel@krustophenia.net>
User-Agent: Mutt/1.4.2.1i
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thunderbolt.ipaska.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - audioslack.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 06:13:16PM EST, Lee Revell wrote:
> On Fri, 2004-09-03 at 04:09, Luke Yelavich wrote:
> > On Fri, Sep 03, 2004 at 05:40:34PM EST, Lee Revell wrote:
> > > On Fri, 2004-09-03 at 03:05, Ingo Molnar wrote:
> > Well with Lee's help, I think I have identified an ICE1712 sound driver issue,
> > but this is yet to be determined.
> 
> Hmm, this one is still not fixed, using the latest VP patches?

With R2, it turns out that this problem still exists. If I turn off threading
for either ICE1712 soundcard when it is being used by JACK, I get xruns of
around 3 msecs.

I can't remember the info you needed. What is needed to debug this problem?
-- 
Luke Yelavich
http://www.audioslack.com
luke@audioslack.com
