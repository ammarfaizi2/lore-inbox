Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264078AbTKJT1G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 14:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264080AbTKJT1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 14:27:05 -0500
Received: from ulysses.news.tiscali.de ([195.185.185.36]:32270 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S264078AbTKJT05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 14:26:57 -0500
To: linux-kernel@vger.kernel.org
Path: 127.0.0.1!nobody
From: Peter Matthias <espi@epost.de>
Newsgroups: linux.kernel
Subject: Re: kernel 2.6 : cdc_acm problem
Date: Mon, 10 Nov 2003 20:16:15 +0100
Organization: Tiscali Germany
Message-ID: <v5ooob.eg.ln@127.0.0.1>
References: <Q1or.1EU.17@gated-at.bofh.it> <Q6Hy.T5.11@gated-at.bofh.it>
NNTP-Posting-Host: p62.246.113.118.tisdip.tiscali.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: ulysses.news.tiscali.de 1068492044 53122 62.246.113.118 (10 Nov 2003 19:20:44 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Mon, 10 Nov 2003 19:20:44 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH schrieb:

> On Sun, Nov 09, 2003 at 09:21:59AM -0800, David Brownell wrote:
>> The problem is that cdc_acm calls a "softirq-only" routine
>> in a hardirq context.  See this patch:
>> 
>> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=106764585001038&w=2
>> 
>> It's not clear that'll make it into 2.6.0-final.
> 
> I've not planned to submit it for 2.6.0 as it's a relativly big change,
> and I don't have the hardware to test it out.  Anyone have any other
> thoughts about this?

IMO it's a must be fixed issue for 2.6.0 and it works on my system.

Peter

