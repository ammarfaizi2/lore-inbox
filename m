Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbSLQRLO>; Tue, 17 Dec 2002 12:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbSLQRLO>; Tue, 17 Dec 2002 12:11:14 -0500
Received: from mail.zmailer.org ([62.240.94.4]:31966 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S265168AbSLQRLM>;
	Tue, 17 Dec 2002 12:11:12 -0500
Date: Tue, 17 Dec 2002 19:19:08 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021217171908.GY32122@mea-ext.zmailer.org>
References: <Pine.LNX.4.44.0212171556110.1460-100000@localhost.localdomain> <Pine.LNX.4.44.0212170906420.2702-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212170906420.2702-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 09:07:21AM -0800, Linus Torvalds wrote:
> On Tue, 17 Dec 2002, Hugh Dickins wrote:
> > I thought that last page was intentionally left invalid?
> 
> It was. But I thought it made sense to use, as it's the only really
> "special" page.

  In couple of occasions I have caught myself from pre-decrementing
  a char pointer which "just happened" to be NULL.

  Please keep the last page, as well as a few of the first pages as
  NULL-pointer poisons.

> But yes, we should decide on this quickly - it's easy to change right now,
> but..
> 
> 		Linus

/Matti Aarnio
