Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318117AbSHBEWZ>; Fri, 2 Aug 2002 00:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318118AbSHBEWZ>; Fri, 2 Aug 2002 00:22:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58016 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318117AbSHBEWZ>;
	Fri, 2 Aug 2002 00:22:25 -0400
Date: Thu, 01 Aug 2002 21:13:57 -0700 (PDT)
Message-Id: <20020801.211357.93822733.davem@redhat.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: large page patch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <aid0he$1h4$1@penguin.transmeta.com>
References: <3D49D45A.D68CCFB4@zip.com.au>
	<737220000.1028250590@flay>
	<aid0he$1h4$1@penguin.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: torvalds@transmeta.com (Linus Torvalds)
   Date: Fri, 2 Aug 2002 04:07:10 +0000 (UTC)
   
   Of course, if you can actually measure it, that would be
   interesting.  Naive math gives you a guess for the order of
   magnitude effect, but nothing beats real numbers ;)

The SYSV folks actually did have a buddy allocator a long time ago and
they did implement lazy coalescing because is supposedly improved
performance.

See chapter 12 section 7 in "Unix Internals" by Uresh Vahalia.
