Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268735AbUI2Rna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268735AbUI2Rna (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 13:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268751AbUI2Rna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 13:43:30 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:5335 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268735AbUI2Rn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 13:43:27 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, rl@hellgate.ch
In-Reply-To: <20040928000516.GA3096@elte.hu>
References: <1094683020.1362.219.camel@krustophenia.net>
	 <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>
	 <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>
	 <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>
	 <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>
	 <20040924074416.GA17924@elte.hu>  <20040928000516.GA3096@elte.hu>
Content-Type: text/plain
Message-Id: <1096479806.1600.13.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 29 Sep 2004 13:43:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 20:05, Ingo Molnar wrote:
> i've released the -S7 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm4-S7
> 

I think I might be seeing the mysterious network problems that K. R.
Foley reported.  The symptoms are that Evolution often fails to download
mail with various errors like "Interrupted system call", "Connection
reset by peer".  I can't rule out a bug in Evolution, but this did not
seem to happen with 2.6.8.1.

These problems could also be related to the changes to the via-rhine
driver.  ISTR that when the VP patches were based on 2.6.8.1, I applied
the patches from -mm4 affecting via-rhine, and that was when the problem
was introduced.

I will try backing these out and see if the problem goes away.

Lee

