Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263025AbTC0PvL>; Thu, 27 Mar 2003 10:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263028AbTC0PvL>; Thu, 27 Mar 2003 10:51:11 -0500
Received: from bitmover.com ([192.132.92.2]:43442 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S263025AbTC0PvK>;
	Thu, 27 Mar 2003 10:51:10 -0500
Date: Thu, 27 Mar 2003 08:02:20 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: ECC error in 2.5.64 + some patches
Message-ID: <20030327160220.GA29195@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030324212813.GA6310@osiris.silug.org> <20030324180107.A14746@vger.timpanogas.org> <20030324234410.GB10520@work.bitmover.com> <20030324182508.A15039@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324182508.A15039@vger.timpanogas.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting these on the machine we use to do the BK->CVS conversions.
My guess is that this means there was a memory error and ECC fixed it.
The only problem is that I'm reasonably sure that there isn't ECC on
these DIMMs.  Does anyone have the table of error codes to explanations?
Google didn't find anything for this one.

Thanks.

Message from syslogd@slovax at Thu Mar 27 05:53:49 2003 ...
slovax kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.

Message from syslogd@slovax at Thu Mar 27 05:53:49 2003 ...
slovax kernel: Bank 1: 9000000000000151

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
