Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267921AbUIWBNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267921AbUIWBNU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 21:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUIWBNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 21:13:20 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:64130 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267921AbUIWBNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 21:13:11 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S3
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@Raytheon.com
In-Reply-To: <20040922103340.GA9683@elte.hu>
References: <20040907092659.GA17677@elte.hu>
	 <20040907115722.GA10373@elte.hu>
	 <1094597988.16954.212.camel@krustophenia.net>
	 <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net>
	 <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>
	 <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>
	 <20040921074426.GA10477@elte.hu>  <20040922103340.GA9683@elte.hu>
Content-Type: text/plain
Message-Id: <1095901987.1758.13.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 22 Sep 2004 21:13:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-22 at 06:33, Ingo Molnar wrote:
> i've released the -S3 VP patch:
> 
>    http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S3
> 

Ingo, it looks like there are still a few hardware configurations on
which the VP patches just don't work:

http://eca.cx/lad/2004/09/0221.html

This user definitely knows what they are doing.  IIRC the problems were
introduced with -O5, which involved big SMP changes so this really looks
like a bug.  Any ideas?

Lee


