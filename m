Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318322AbSHEFui>; Mon, 5 Aug 2002 01:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318323AbSHEFuh>; Mon, 5 Aug 2002 01:50:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25279 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318322AbSHEFug>;
	Mon, 5 Aug 2002 01:50:36 -0400
Date: Sun, 04 Aug 2002 22:40:43 -0700 (PDT)
Message-Id: <20020804.224043.06804556.davem@redhat.com>
To: frankeh@watson.ibm.com
Cc: torvalds@transmeta.com, davidm@hpl.hp.com, davidm@napali.hpl.hp.com,
       gh@us.ibm.com, Martin.Bligh@us.ibm.com, wli@holomorpy.com,
       linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200208041331.24895.frankeh@watson.ibm.com>
References: <Pine.LNX.4.44.0208031027330.3981-100000@home.transmeta.com>
	<20020803.172836.60864598.davem@redhat.com>
	<200208041331.24895.frankeh@watson.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hubertus Franke <frankeh@watson.ibm.com>
   Date: Sun, 4 Aug 2002 13:31:24 -0400
   
   Can we tweak the buddy allocator to give us this additional functionality?

Absolutely not, it's a total lose.

I have tried at least 5 times to make it work without fragmenting the
buddy lists to shit.  I channege you to code one up that works without
fragmenting things to shreds.  Just run an endless kernel build over
and over in a loop for a few hours to a day.  If the buddy lists are
not fragmented after these runs, then you have succeeded in my
challenge.

Do not even reply to this email without meeting the challenge as it
will fall on deaf ears.  I've been there and I've done that, and at
this point code talks bullshit walks when it comes to trying to
colorize the buddy allocator in a way that actually works and isn't
disgusting.
