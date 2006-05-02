Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWEBPgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWEBPgG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWEBPgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:36:06 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:55211 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S964891AbWEBPgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:36:04 -0400
Subject: Re: [lockup] 2.6.17-rc3: netfilter/sctp: lockup in sctp_new(),
	do_basic_checks()
From: Marcel Holtmann <marcel@holtmann.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>, coreteam@netfilter.org
In-Reply-To: <20060502113454.GA28601@elte.hu>
References: <20060502113454.GA28601@elte.hu>
Content-Type: text/plain
Date: Tue, 02 May 2006 17:34:41 +0200
Message-Id: <1146584081.19488.57.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

> running an "isic" stresstest on and against a testbox [which, amongst 
> other things, generates random incoming and outgoing packets] on 
> 2.6.17-rc3 (and 2.6.17-rc3-mm1) over gigabit results in a reproducible 
> lockup, after 5-10 minutes of runtime:

does this lockup the local machine you run the stresstest on or the
remote machine you run the test against?

Regards

Marcel


