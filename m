Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVAMVab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVAMVab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVAMV2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:28:51 -0500
Received: from quechua.inka.de ([193.197.184.2]:1500 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261688AbVAMVYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:24:10 -0500
From: Bernd Eckenfels <ecki-news2005-01@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: NUMA or not on dual Opteron
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20050113094537.GB2547@favonius>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CpCRr-0002lv-00@calista.eckenfels.6bone.ka-ip.net>
Date: Thu, 13 Jan 2005 22:24:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050113094537.GB2547@favonius> you wrote:
> I was under the impression that NUMA is useful on > 2-way systems only.
> Is this true, and if not, under what circumstances is NUMA useful on
> 2-way Opteron systems?

NUMA is good for all situations where you have more than one CPU and the
CPUs have different access speeds for some parts of the memory (i.e. cpu
local memory). This is true for SMP Opterons, not for the usual Intel
Boards.

Greetings
Bernd
y
