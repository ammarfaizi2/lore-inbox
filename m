Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbTJ0Koy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 05:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbTJ0Koy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 05:44:54 -0500
Received: from gate.in-addr.de ([212.8.193.158]:41943 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261555AbTJ0Kox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 05:44:53 -0500
Date: Mon, 27 Oct 2003 11:29:19 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel Phillips <phillips@arcor.de>, Nick Piggin <piggin@cyberone.com.au>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
Message-ID: <20031027102919.GC13640@marowsky-bree.de>
References: <20031013140858.GU1107@suse.de> <200310231920.39888.phillips@arcor.de> <3F986276.4010409@cyberone.com.au> <200310262206.53904.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200310262206.53904.phillips@arcor.de>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-10-26T23:06:53,
   Daniel Phillips <phillips@arcor.de> said:

> Not entirely within the multipath virtual device, that's the problem.
> If it could stay somehow all within one device driver then ok, but
> since we want to build this modularly, as a device mapper target,
> there are API issues.

Are you seeing problems with the write-ordering properties of
multipathing? If so, what is the issue with handling them in the DM
target once?


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

