Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277012AbRJQRzM>; Wed, 17 Oct 2001 13:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277011AbRJQRzC>; Wed, 17 Oct 2001 13:55:02 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:47509 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S277013AbRJQRyt>; Wed, 17 Oct 2001 13:54:49 -0400
Date: Mon, 15 Oct 2001 17:35:34 +0200 (CEST)
From: Pascal Schmidt <pleasure.and.pain@web.de>
To: Erik Tews <erik.tews@gmx.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.12-ac1: BUG in sched.c:712
In-Reply-To: <20011015140507.D22287@no-maam.dyndns.org>
Message-ID: <Pine.LNX.4.33.0110151731400.979-100000@neptune.sol.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001, Erik Tews wrote:

> I am very sure that this oops is related to mppp. There seems to be a
> bug in the mppp-code which produces exactly this output (the lines with
> -1 at the end and then a oops during sceduling). I asked at the
> isdn4linux-devel-list but the mppp-code seems to be so dirty that they
> think it would be easyer to rewrite it than debugging it. So I think
> there will be no fast solution for this problem.
If it only happens when the ISP drops the connection while running mppp, I
can easily avoid the situation until a solution gets developed. My ISP
drops the connection automatically after 12 hours but allows immediate
reconnection. So a little magic with ip-up, cron, and ip-down is enough to
avoid the bug, I can easily disable mppp and the connection a few minutes
before the 12 hours pass and then bring the connection and mppp back up a
few moments later.

-- 
Ciao, Pascal

-<[ pharao90@tzi.de, netmail 2:241/215.72, home http://cobol.cjb.net/) ]>-

