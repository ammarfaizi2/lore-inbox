Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbSI1CAu>; Fri, 27 Sep 2002 22:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262683AbSI1CAu>; Fri, 27 Sep 2002 22:00:50 -0400
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:57322
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id <S262682AbSI1CAs>; Fri, 27 Sep 2002 22:00:48 -0400
From: David Mosberger-Tang <David.Mosberger@acm.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] 'virtual => physical page mapping cache' take #2, vcache-2.5.38-C4
Date: Fri, 27 Sep 2002 21:18:06 GMT
Message-Id: <20020928020609.3A1916E0@panda.mostang.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 27 Sep 2002 20:50:08 +0200, Ingo Molnar <mingo@elte.hu> said:

  Ingo> tmp = follow_page(current->mm, uaddr, 0);

How about making this a platform-specific routine?  I think a fair
number of arches provide special instruction for this (at least when
mm == current->mm).

	--david
--
Interested in learning more about IA-64 Linux?  Try http://www.lia64.org/book/
