Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266797AbRGXDmN>; Mon, 23 Jul 2001 23:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266808AbRGXDmD>; Mon, 23 Jul 2001 23:42:03 -0400
Received: from [216.101.162.242] ([216.101.162.242]:5760 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266797AbRGXDl6>;
	Mon, 23 Jul 2001 23:41:58 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15196.61008.690839.396406@pizda.ninka.net>
Date: Mon, 23 Jul 2001 20:41:04 -0700 (PDT)
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: chris@scary.beasts.org (Chris Evans), linux-kernel@vger.kernel.org
Subject: Re: Minor net/core/sock.c security issue?
In-Reply-To: <200107240302.f6O32iB279266@saturn.cs.uml.edu>
In-Reply-To: <15196.45004.237634.928656@pizda.ninka.net>
	<200107240302.f6O32iB279266@saturn.cs.uml.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Albert D. Cahalan writes:
 > Long term, __builtin_min() and __builtin_max() would be nice.

I would even avoid this, what is the signedness of their
arguments and return values?  The answer is: I don't care,
because I have to look it up.

And if I have to look it up, I know that most people _won't_ look it
up and will just guess or assume.  Most people are therefore likely to
misuse it.

Later,
David S. Miller
davem@redhat.com
