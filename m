Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUCWAQA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 19:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbUCWAQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 19:16:00 -0500
Received: from mail.ccur.com ([208.248.32.212]:45835 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S261187AbUCWAP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 19:15:59 -0500
Date: Mon, 22 Mar 2004 19:14:33 -0500
From: Joe Korty <joe.korty@ccur.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       Paul Jackson <pj@sgi.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] broken bitmap_parse for ncpus > 32
Message-ID: <20040323001433.GA29320@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040322202118.GA27281@tsunami.ccur.com> <20040322231246.GQ2045@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322231246.GQ2045@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Bugfixes are always good. Maybe the kerneldoc stuff would be a good idea
> for these functions, and the rest of the non-static functions ppl might
> be expected to call.

IMO, one+ liners describing how a function is used is best put near
the function, where it is most likely to be seen.  Stuff going into
Documentation/*.txt should be bulky stuff not suitable for inlining,
such as largish tutorials, annotated examples, theory papers, etc. 

Joe
