Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268683AbUJEB17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268683AbUJEB17 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 21:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268700AbUJEB17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 21:27:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:48008 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268683AbUJEB14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 21:27:56 -0400
Subject: Re: [PATCH] I/O space write barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1096936344.2674.198.camel@cube>
References: <1096922369.2666.177.camel@cube>
	 <200410041420.01266.jbarnes@engr.sgi.com>  <1096936344.2674.198.camel@cube>
Content-Type: text/plain
Message-Id: <1096939347.24537.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 05 Oct 2004 11:22:27 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 10:32, Albert Cahalan wrote:


> Ideally, it would be eieio, and the eieio in each
> of the IO operations would be removed. Finding and
> fixing all the drivers that break looks impossible
> though; most driver developers will be on x86 boxes.

I don't agree. IO operations shouldn't be relaxed by
default. That's really asking too much of driver writers

Ben.

