Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266105AbUFWEoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266105AbUFWEoB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 00:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUFWEoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 00:44:01 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:30986 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S266105AbUFWEn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 00:43:59 -0400
Message-ID: <1087957407.40d8e99fb1398@vds.kolivas.org>
Date: Wed, 23 Jun 2004 12:23:27 +1000
From: kernel@kolivas.org
To: Diffie <diffie@gmail.com>
Cc: Panagiotis Papadakos <papadako@csd.uoc.gr>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staircase 7.1 for 2.6.7-mm1
References: <9dda34920406222056500f67d3@mail.gmail.com>
In-Reply-To: <9dda34920406222056500f67d3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Diffie <diffie@gmail.com>:

> I have tried this staircase patch on 2.6.7-mm1 kernel under NForce2
> based system and when playing games the sound stops and skips every
> second and moving mouse at the same time makes the response very
> slow.The game is Unreal engine based.

Most hardware got better for this problem with s7.1. There is a new release that
addressed a few bugs only just announced on lkml (staircase 7.3) which seemed
to fix this problem on machines tested so far. This should address these
issues.

Note that at very high loads mainline will be more responsive, but it does this
to the detriment of fairness which I decided was not worth pursuing in
staircase. The machine should will be usable at these very high loads - which
is important when a box goes out of control - but it will not be as smooth as
mainline.

Thanks for feedback.

Cheers,
Con
