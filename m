Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVDQBEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVDQBEI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 21:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVDQBEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 21:04:08 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:54931 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261229AbVDQBEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 21:04:05 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: Coredump when program run as root?
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 17 Apr 2005 03:03:34 +0200
References: <3U03M-4Jx-15@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DMyCF-0001jq-5c@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Hildebrandt <Ralf.Hildebrandt@charite.de> wrote:

> Most UNIX variants disable core dumps in programs that have changed their
> uid or euid during operation.  This includes Solaris and Linux.
> 
> Well, squid does exactly that. How can I still get a coredump? I really
> need one. Kernel 2.6.11.7

It cannot change the (e)uid if it is run as user. Maybe this helps.
-- 
Top 100 things you don't want the sysadmin to say:
78. Do you smell something?
