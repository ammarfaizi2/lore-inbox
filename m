Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261313AbSIWTIS>; Mon, 23 Sep 2002 15:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261332AbSIWSli>; Mon, 23 Sep 2002 14:41:38 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261308AbSIWSlY>;
	Mon, 23 Sep 2002 14:41:24 -0400
To: Jakub Jelinek <jakub@redhat.com>
Cc: Con Kolivas <conman@kolivas.net>, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
References: <Pine.LNX.3.95.1020923101125.3233A-100000@chaos.analogic.com>
	<1032791089.3d8f2431231ac@kolivas.net>
	<20020923103417.V21220@devserv.devel.redhat.com>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 23 Sep 2002 18:03:17 +0200
In-Reply-To: Jakub Jelinek's message of "Mon, 23 Sep 2002 10:34:17 -0400"
Message-ID: <yw1xofaowv5m.fsf@calippo.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek <jakub@redhat.com> writes:

> BTW: Have you tried gcc 3.2 with say -finline-limit=2000 too?
> By default gcc 3.2 has for usual C code smaller inlining cutoff, so the IO
> difference might as well be because some important, but big function was
> inlined by 2.95.x and not by 3.2.x. On the other side there is
> __attribute__((always_inline)) which you can use to tell gcc you don't
> want any cutoff for a particular function.

How about using -Winline?

-- 
Måns Rullgård
mru@users.sf.net
