Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267291AbUJRSNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267291AbUJRSNu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267359AbUJRSKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:10:34 -0400
Received: from waste.org ([209.173.204.2]:407 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S267294AbUJRSJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:09:18 -0400
Date: Mon, 18 Oct 2004 13:08:51 -0500
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Enough with the ad-hoc naming schemes, please
Message-ID: <20041018180851.GA28904@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus,

I can't help but notice you've broken all the tools that rely on a
stable naming scheme TWICE in the span of LESS THAN ONE POINT RELEASE.

In both cases, this could have been avoided by using Marcello's 2.4
naming scheme. It's very simple: when you think something is "final",
you call it a "release candidate" and tag it "-rcX". If it works out,
you rename it _unmodified_ and everyone can trust that it hasn't
broken again in the interval. If it's not "final" and you're accepting
more than bugfixes, you call it a "pre-release" and tag it "-pre".
Then developers and testers and automated tools all know what to
expect.

-- 
Mathematics is the supreme nostalgia of our time.

