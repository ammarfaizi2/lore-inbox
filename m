Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbUDRVsz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 17:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264186AbUDRVsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 17:48:55 -0400
Received: from main.gmane.org ([80.91.224.249]:3286 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263771AbUDRVsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 17:48:54 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: 2.6.5 pts problem
Date: Sun, 18 Apr 2004 14:48:51 -0700
Message-ID: <pan.2004.04.18.21.48.51.328157@triplehelix.org>
References: <1082305539.15497.2.camel@midux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-186-145.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Apr 2004 19:25:40 +0300, Markus Hästbacka wrote:
> midian   pts/93   :0.0             19:24    0.00s  0.00s  0.00s w
>              ^^
> As you see, pts is just growing, not using the old used numbers.

The implementation was changed intentionally to make it that way. The
numbers will only be recycled once we go over the max number of
psuedoterminals, I think..

-- 
Joshua Kwan


