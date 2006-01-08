Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161075AbWAHAAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbWAHAAe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 19:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161077AbWAHAAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 19:00:34 -0500
Received: from canuck.infradead.org ([205.233.218.70]:48843 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1161075AbWAHAAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 19:00:34 -0500
Subject: Re: [2.6 patch] no longer mark MTD_OBSOLETE_CHIPS as BROKEN and
	remove broken MTD_OBSOLETE_CHIPS drivers
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
In-Reply-To: <20060107220702.GZ3774@stusta.de>
References: <20060107220702.GZ3774@stusta.de>
Content-Type: text/plain
Date: Sun, 08 Jan 2006 00:00:09 +0000
Message-Id: <1136678409.30348.26.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-07 at 23:07 +0100, Adrian Bunk wrote:
> This patch brings the MTD_SHARP driver back into life and removes the 
> non-compiling MTD_AMDSTD and MTD_JEDEC with everything depending on 
> them.

Please provide further background on your reasoning. I'll enumerate my
questions to make it easy for you to answer each one fully.

1. Precisely when were these chip drivers marked obsolete?

2. What was the reason for marking them obsolete?

3. What are the factors which led you to conclude that _now_ is the time
to actually remove them?

4. What are the factors which led you to _remove_ the map drivers which
currently use the obsolete chip drivers, rather than taking the obvious
alternative solution for those map drivers?

-- 
dwmw2

