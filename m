Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSLHUAn>; Sun, 8 Dec 2002 15:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbSLHUAm>; Sun, 8 Dec 2002 15:00:42 -0500
Received: from packet.digeo.com ([12.110.80.53]:31981 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261593AbSLHUAm>;
	Sun, 8 Dec 2002 15:00:42 -0500
Message-ID: <3DF3A6B0.A67A70BD@digeo.com>
Date: Sun, 08 Dec 2002 12:08:16 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50 + e100 benchmarking
References: <20021208124444.GA18751@krispykreme>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Dec 2002 20:08:16.0563 (UTC) FILETIME=[8B92E030:01C29EF5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
> 
> On the send side (sock_source) the higher interrupt rate shows up.
> (hmm I wonder how we got idle time here, cyclesoak should have sucked
> all of it up).

That has to be a CPU scheduler problem; I think Andrea identified
a glitch which could do that.

Could you put together an isolated testcase?
