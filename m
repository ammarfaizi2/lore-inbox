Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262635AbSIPRAX>; Mon, 16 Sep 2002 13:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262621AbSIPRAX>; Mon, 16 Sep 2002 13:00:23 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:18581 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262635AbSIPRAW>; Mon, 16 Sep 2002 13:00:22 -0400
Subject: Re: [patch] Re: New failures in nightly LTP test
From: Paul Larson <plars@linuxtestproject.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0209141227410.16893-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0209141227410.16893-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 16 Sep 2002 11:50:48 -0500
Message-Id: <1032195049.3362.77.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-14 at 05:30, Ingo Molnar wrote:

> the attached patch (against BK-curr) fixes this bug and a number of others
> in the same class - the signal behavior bitmasks should never be consulted
> before making sure that the signal is in the word range. Paul, does this
> fix all the LTP regressions?
Yes, it worked great.  Sorry for the delay, I was away for the weekend.

Thanks,
Paul Larson

