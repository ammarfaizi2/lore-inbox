Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130294AbRCBDAo>; Thu, 1 Mar 2001 22:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130301AbRCBDAZ>; Thu, 1 Mar 2001 22:00:25 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:14863 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130294AbRCBDAO>; Thu, 1 Mar 2001 22:00:14 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
Date: 1 Mar 2001 18:58:49 -0800
Organization: Transmeta Corporation
Message-ID: <97n299$f4l$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0103012021470.1542-100000@mikeg.weiden.de> <Pine.LNX.4.33.0103011747560.1961-100000@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0103011747560.1961-100000@duckman.distro.conectiva>,
Rik van Riel  <riel@conectiva.com.br> wrote:
>
>I haven't tested it yet for a number of reasons. The most
>important one is that the FreeBSD people have been playing
>with this thing for a few years now and Matt Dillon has
>told me the result of their tests ;)

Note that the Linux VM is certainly different enough that I doubt the
comparisons are all that valid. Especially actual virtual memory mapping
is basically from another planet altogether, and heuristics that are
appropriate for *BSD may not really translate all that better.

I'll take numbers over talk any day.  At least Mike had numbers, and
possible explanations for them. He also removed more code than he added,
which is always a good sign. 

In short, please don't argue against numbers. 

		Linus
