Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264231AbUHCGv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbUHCGv4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 02:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265091AbUHCGv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 02:51:56 -0400
Received: from colin2.muc.de ([193.149.48.15]:1042 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264231AbUHCGvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 02:51:55 -0400
Date: 3 Aug 2004 08:51:54 +0200
Date: Tue, 3 Aug 2004 08:51:54 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
Message-ID: <20040803065154.GA85840@muc.de>
References: <2oEEn-197-9@gated-at.bofh.it> <m3isc1smag.fsf@averell.firstfloor.org> <410EDBF5.40205@bigpond.net.au> <20040802205332.3413cd6d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802205332.3413cd6d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But let me re-repeat again that CPU scheduler problems tend to take a
> _long_ time to turn up - you make some change and two months later some
> person with a weird workload on expensive hardware hits a nasty corner
> case.  So I do think that we'd have to hit a nasty problem with the current
> scheduler to go making deep changes.

How about just simplifying the code? Both Con's and Peter's code 
look a lot simpler compared to the stock scheduler and are easier 
to understand. If they don't work significantly worse I think that
would be a strong argument to move to one of them.

-Andi

