Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVEaV5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVEaV5J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 17:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVEaV5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 17:57:09 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:57355 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261591AbVEaV5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 17:57:01 -0400
Date: Tue, 31 May 2005 15:01:51 -0700
To: Karim Yaghmour <karim@opersys.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, Nick Piggin <nickpiggin@yahoo.com.au>,
       kus Kusche Klaus <kus@keba.com>, James Bruce <bruce@andrew.cmu.edu>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050531220151.GA1804@nietzsche.lynx.com>
References: <Pine.OSF.4.05.10505302125520.31148-100000@da410.phys.au.dk> <429B70F2.20602@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429B70F2.20602@opersys.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 04:00:50PM -0400, Karim Yaghmour wrote:
> Here's for the fun of history, a diff between the 8390.c in 2.2.16 and the
> one in rt-net 0.9.0:

This is really interesting code. It's really not unlike what preempt RT
is already doing with the atomic locking (replacement). From the looks
of it conversion of an ethernet driver to be RT capable is shockingly
trivial.

bill

