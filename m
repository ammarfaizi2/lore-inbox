Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269306AbUIBXfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269306AbUIBXfS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269305AbUIBXcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:32:55 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:35473 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269307AbUIBXcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:32:11 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q8
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <20040902232839.GA32440@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
	 <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu>
	 <1094108653.11364.26.camel@krustophenia.net>
	 <20040902071525.GA19925@elte.hu>
	 <1094167534.1571.10.camel@krustophenia.net>
	 <20040902232839.GA32440@elte.hu>
Content-Type: text/plain
Message-Id: <1094167928.1571.13.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 02 Sep 2004 19:32:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 19:28, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Do you see any optional networking features in the trace (other than
> > ip_conntrack)?  I was under the impression that I had everything
> > optional disabled.
> 
> yeah, it seems to be only ip_conntrack and netfilter (which conntrack
> relies on).
> 

FWIW these seem to only slow down the single packet path by about 10%. 
This is pretty good.

Lee

