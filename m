Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274668AbRITWBJ>; Thu, 20 Sep 2001 18:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274667AbRITWBB>; Thu, 20 Sep 2001 18:01:01 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:44579 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274590AbRITWAv>; Thu, 20 Sep 2001 18:00:51 -0400
Subject: Re: [PATCH] Preemption Latency Measurement Tool
From: Robert Love <rml@tech9.net>
To: Tobias Diedrich <ranma@gmx.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010920220121.A18683@router.ranmachan.dyndns.org>
In-Reply-To: <1000939458.3853.17.camel@phantasy> 
	<20010920220121.A18683@router.ranmachan.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.19.21.54 (Preview Release)
Date: 20 Sep 2001 18:01:15 -0400
Message-Id: <1001023279.6048.224.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-20 at 16:01, Tobias Diedrich wrote:
> Should the patch work with SMP systems ?
> Here is what I get:

I never thought that it shouldn't, but upon thinking about it maybe it
won't :)

You are the second person reporting those all-the-same latency values. 
I think the SMP locks are being reported wrongly by the patch.  I will
take a look at it.

Thanks

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

