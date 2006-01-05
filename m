Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWAENC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWAENC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 08:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWAENC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 08:02:58 -0500
Received: from soundwarez.org ([217.160.171.123]:48334 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751330AbWAENC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 08:02:57 -0500
Date: Thu, 5 Jan 2006 14:02:49 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Subject: 80 column line limit?
Message-ID: <20060105130249.GB29894@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can't we relax the 80 column line rule to something more comfortable?
These days descriptive variable/function names are much more valuable,
I think.

Just by looking at random examples in the tree, seems the 80 column
rule does more harm than good. I always find myself start shortening
names just to fit the line limit and not to need to line-wrap a statement.
We even use #defines sometimes to access simple structure members and
the like, only to fit that rule.

So, are we sure that 80 columns is still valuable, looking at the
side-effects of artificially shortended variable/function names and
line-wrapped statements, caused by this rule?

Thanks,
Kay
