Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUGSJUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUGSJUM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 05:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264858AbUGSJUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 05:20:12 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:43483 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264857AbUGSJUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 05:20:08 -0400
Date: Mon, 19 Jul 2004 11:19:43 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Cc: gilbertd@treblig.org, nickpiggin@yahoo.com.au, kladit@t-online.de
Subject: Re: rsync out of memory 2.6.8-rc2
Message-ID: <20040719091943.GA866@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ID: rxOzKYZQoeuWI3SLJtBPV0IV+DcP9TKcD4RnGYzr9irJ7g4Is+moEh
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick your mail got lost here, sorry.

I did rsync -av xeon2:/disc1 . on the target system.
xeon2 is the system that gets out of memory.
/disc1 is 60GB and contains several thousand files.
I think this is a common backup situation.

I found out I could trigger the memory outage using du -s /disc1 too.

-- 
Klaus
