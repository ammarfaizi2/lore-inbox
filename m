Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWIWKog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWIWKog (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 06:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWIWKog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 06:44:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14786 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751493AbWIWKof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 06:44:35 -0400
Subject: Re: 2.6.19 -mm merge plans
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Rongkai.Zhan" <rongkai.zhan@windriver.com>,
       linux-mtd@lists.infradead.org
In-Reply-To: <1158917046.24527.662.camel@pmac.infradead.org>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	 <1158917046.24527.662.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Sat, 23 Sep 2006 11:44:27 +0100
Message-Id: <1159008267.24527.908.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-22 at 10:24 +0100, David Woodhouse wrote:
> Merged, with the exception of the unlock addr one which I'm still not
> sure about -- about to investigate harder. 

Please drop it (fix-the-unlock-addr-lookup-bug-in-mtd-jedec-probe.patch).

Returning the first value in the array is intentional -- it should be
automatically shifted to make it work if it's a x16 chip, and the right
thing should happen. If _that_ isn't working, give details and we'll
work out a proper fix.

-- 
dwmw2

