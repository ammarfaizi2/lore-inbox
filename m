Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271715AbTHHRkB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 13:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271731AbTHHRkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 13:40:01 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:41733 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S271715AbTHHRj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 13:39:58 -0400
Subject: Re: 2.6: More about interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Szonyi Calin <sony@etc.utt.ro>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <28816.194.138.39.55.1060356015.squirrel@webmail.etc.utt.ro>
References: <1060280139.1406.17.camel@teapot.felipe-alfaro.com>
	 <28816.194.138.39.55.1060356015.squirrel@webmail.etc.utt.ro>
Content-Type: text/plain
Message-Id: <1060364377.600.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 08 Aug 2003 19:39:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-08 at 17:20, Szonyi Calin wrote:

> Some comments:
> Renicing X at -20 is silly. It is normal that xmms skips when
> X is reniced because X gets the cpu time not xmms.

I didn't say XMMS skips when X is reniced at -20 :-)
It's Juk the one that skips and, as one LKLM reader said, it has to do
with the fact that aRTS had less priority than X.

> Also a normal user doesn't have access to nice values below
> zero, so the scheduler should work for normal systems not
> for those in which process foo is reniced at -bar priority.

Can't follow you reasoning. I think the scheduler should work for any
priority, either negative (the most) or possitive (the least). In fact,
some kernel threads are reniced negatively since they need full
priority.

