Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUIVPLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUIVPLA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 11:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUIVPLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 11:11:00 -0400
Received: from mail3.utc.com ([192.249.46.192]:13728 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S266117AbUIVPK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 11:10:58 -0400
Message-ID: <41519539.4010407@cybsft.com>
Date: Wed, 22 Sep 2004 10:07:37 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S3
References: <20040907092659.GA17677@elte.hu> <20040907115722.GA10373@elte.hu> <1094597988.16954.212.camel@krustophenia.net> <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>
In-Reply-To: <20040922103340.GA9683@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i've released the -S3 VP patch:
> 
>    http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S3
> 

In order to get this to build I had to add

#include <asm/delay.h>

to linux/kernel/time.c

kr
