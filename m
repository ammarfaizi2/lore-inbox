Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266474AbUHILIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUHILIS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 07:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266484AbUHILIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 07:08:18 -0400
Received: from [213.146.154.40] ([213.146.154.40]:53708 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266474AbUHILIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 07:08:17 -0400
Subject: Re: [BUG] 2.6.8-rc3 slab corruption (jffs2?)
From: David Woodhouse <dwmw2@infradead.org>
To: Wu Jian Feng <jianfengw@mobilesoft.com.cn>, Dan Brown <dan_brown@ieee.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-mtd@lists.infradead.org,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092033702.1438.2169.camel@imladris.demon.co.uk>
References: <20040807150458.E2805@flint.arm.linux.org.uk>
	 <20040808061206.GA5417@mobilesoft.com.cn>
	 <1091962414.1438.977.camel@imladris.demon.co.uk>
	 <20040809015950.GA20408@mobilesoft.com.cn>
	 <1092033702.1438.2169.camel@imladris.demon.co.uk>
Content-Type: text/plain
Message-Id: <1092049678.4383.5149.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 09 Aug 2004 12:07:59 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 07:41 +0100, David Woodhouse wrote:
> Russell hasn't been able to reproduce it. Can you? If so, how -- and can
> you do same with CONFIG_JFFS2_FS_DEBUG=1 and show me the output?

Don't bother, thanks. I found the problem, in the part_erase() code.
Waiting for the culprit to wake up and fix it... :)

-- 
dwmw2

