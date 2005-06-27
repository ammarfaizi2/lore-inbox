Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVF0X7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVF0X7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVF0X7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:59:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45524 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262041AbVF0X70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:59:26 -0400
Date: Mon, 27 Jun 2005 19:59:11 -0400 (EDT)
From: Rik Van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Ed Tomlinson <tomlins@cam.org>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Song Jiang <sjiang@lanl.gov>
Subject: Re: [PATCH] 0/2 swap token tuning
In-Reply-To: <200506271946.33083.tomlins@cam.org>
Message-ID: <Pine.LNX.4.61.0506271958400.3784@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0506261827500.18834@chimarrao.boston.redhat.com>
 <200506271946.33083.tomlins@cam.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2005, Ed Tomlinson wrote:

> What are the suggested  values to put into /proc/sys/vm/swap_token_timeout ?
> The docs are not at all clear about this (proc/filesystems.txt).

Beats me ;)

I tried a number of values in the original implementation, and
300 seconds turned out to work fine...

-- 
The Theory of Escalating Commitment: "The cost of continuing mistakes is
borne by others, while the cost of admitting mistakes is borne by yourself."
  -- Joseph Stiglitz, Nobel Laureate in Economics
