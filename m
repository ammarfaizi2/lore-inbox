Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbUCWAUp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 19:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbUCWAUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 19:20:45 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:35309 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261710AbUCWAUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 19:20:37 -0500
Date: Mon, 22 Mar 2004 16:19:31 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: joe.korty@ccur.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] broken bitmap_parse for ncpus > 32
Message-Id: <20040322161931.1c63ddfd.pj@sgi.com>
In-Reply-To: <20040322231246.GQ2045@holomorphy.com>
References: <20040322202118.GA27281@tsunami.ccur.com>
	<20040322231246.GQ2045@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe the kerneldoc stuff would be a good idea
> for these functions, and the rest of the non-static functions ppl might
> be expected to call.

Not quite sure what Bill is converying here with the qualifier 'non-static'.

My inclinations lay more toward looking for improvements, explored in
other messages on a concurrent thread "[PATCH] Introduce nodemask_t
ADT", to the cpumask API, to be followed by a kerneldoc, rather than
trying very hard to document the current API much more.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
