Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267911AbSIRQv3>; Wed, 18 Sep 2002 12:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267844AbSIRQuX>; Wed, 18 Sep 2002 12:50:23 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:19453
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267883AbSIRQuA>; Wed, 18 Sep 2002 12:50:00 -0400
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
	elimination, 2.5.35-BK
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Ingo Molnar <mingo@elte.hu>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209180906460.1913-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0209180906460.1913-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Sep 2002 17:55:16 +0100
Message-Id: <1032368116.20498.129.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-18 at 17:15, Linus Torvalds wrote:
> Give me one reason for why these two added lines aren't better than all
> the complexity we've discussed? I can pretty much _guarantee_ that it's
> faster, and it sure as hell is simpler

Add a constraint against a hard maximum (tweakable in proc) and I'd
agree.


