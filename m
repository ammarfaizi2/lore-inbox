Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269736AbTGKAwu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 20:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269739AbTGKAwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 20:52:49 -0400
Received: from holomorphy.com ([66.224.33.161]:31413 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S269736AbTGKAwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 20:52:46 -0400
Date: Thu, 10 Jul 2003 18:08:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, Jamie Lokier <jamie@shareable.org>,
       Davide Libenzi <davidel@xmailserver.org>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: 2.5.74-mm1
Message-ID: <20030711010812.GA15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Phillips <phillips@arcor.de>,
	Peter Chubb <peter@chubb.wattle.id.au>,
	Jamie Lokier <jamie@shareable.org>,
	Davide Libenzi <davidel@xmailserver.org>,
	Mel Gorman <mel@csn.ul.ie>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>
References: <20030703023714.55d13934.akpm@osdl.org> <200307100059.57398.phillips@arcor.de> <16140.51447.73888.717087@wombat.chubb.wattle.id.au> <200307110304.11216.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307110304.11216.phillips@arcor.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 03:04:11AM +0200, Daniel Phillips wrote:
> Thinking strictly about the needs of sound processing, what's needed is a 
> guarantee of so much cpu time each time the timer fires, and a user limit to 
> prevent cpu hogging.  It's worth pondering the difference between that and 
> rate-of-forward-progress.  I suspect some simple improvements to the current 
> scheduler can be made to do the job, and at the same time, avoid the 
> priorty-based starvation issue that seems to have been practically mandated 
> by POSIX.

Such scheduling policies are called "isochronous".


-- wli
