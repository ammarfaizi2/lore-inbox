Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSFQVS3>; Mon, 17 Jun 2002 17:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317024AbSFQVS2>; Mon, 17 Jun 2002 17:18:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:11251 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317023AbSFQVS1>; Mon, 17 Jun 2002 17:18:27 -0400
Subject: Re: [PATCH] 2.4-ac: sparc64 support for O(1) scheduler
From: Robert Love <rml@mvista.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020616.222813.04502396.davem@redhat.com>
References: <Pine.LNX.4.44.0206161710240.7461-100000@e2>
	<1024271149.3090.13.camel@sinai> 
	<20020616.222813.04502396.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 17 Jun 2002 14:18:22 -0700
Message-Id: <1024348703.3090.136.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-16 at 22:28, David S. Miller wrote:

> Your changes were pretty, that's part of the problem.  Fixing things
> correctly is 10 times more preferable to a 1 time hack "just for now".

*shrug* I think you are missing my point but that is OK - we really do
not need to fight over it.

The switch_mm patch touched _core_ bits - code that affects i386 which
works fine now in 2.4-ac.  As 2.4-ac is stable and i386 is working fine,
I want to move changes into it slowly and with testing.

If you object to merging the "broken" sparc64 patch now but concede we
can wait for Ingo's patch, then I agree.  In fact, in light of Ingo's
patch Alan should not merge what I sent.  But my opinion would be to
hold off until the new bits saw some testing in 2.5 ... however trivial
they may be.

	Robert Love

