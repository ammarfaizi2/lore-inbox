Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267628AbUHTHRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267628AbUHTHRv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUHTHPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:15:42 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:65258 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267602AbUHTHPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:15:10 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
From: Lee Revell <rlrevell@joe-job.com>
To: karl.vogel@seagha.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <m3brh6g8yi.fsf@seagha.com>
References: <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>
	 <20040819073247.GA1798@elte.hu> <m31xi3j901.fsf@seagha.com>
	 <m3brh6g8yi.fsf@seagha.com>
Content-Type: text/plain
Message-Id: <1092986189.10063.54.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 03:16:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-19 at 16:37, karl.vogel@seagha.com wrote:
> The following latency trace is generated each time the sound driver is opened
> by an application on my box.
> 

This is a pretty big trace.  Please try to trim these, especially if a
few lines repeat hundreds of times (common).

The comment seems to imply that the author didn't like the mdelay but it
didn't work otherwise.  What happens if you get rid of the mdelay?

Lee

