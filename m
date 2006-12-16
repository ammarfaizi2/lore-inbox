Return-Path: <linux-kernel-owner+w=401wt.eu-S1161351AbWLPSni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161351AbWLPSni (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 13:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161352AbWLPSni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 13:43:38 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:36869 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161351AbWLPSnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 13:43:37 -0500
Date: Sat, 16 Dec 2006 18:43:10 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061216184310.GA891@unjust.cyrius.com>
References: <20061207155740.GC1434@torres.l21.ma.zugschlus.de> <4578465D.7030104@cfl.rr.com> <20061209092639.GA15443@torres.l21.ma.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061209092639.GA15443@torres.l21.ma.zugschlus.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marc Haber <mh+linux-kernel@zugschlus.de> [2006-12-09 10:26]:
> Unfortunately, I am lacking the knowledge needed to do this in an
> informed way. I am neither familiar enough with git nor do I possess
> the necessary C powers.

I wonder if what you're seein is related to
http://lkml.org/lkml/2006/12/16/73

You said that you don't see any corruption with 2.6.18.  Can you try
to apply the patch from
http://www2.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=d08b3851da41d0ee60851f2c75b118e1f7a5fc89
to 2.6.18 to see if the corruption shows up?
-- 
Martin Michlmayr
tbm@cyrius.com
