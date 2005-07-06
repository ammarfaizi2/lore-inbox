Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVGFRvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVGFRvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 13:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVGFRvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 13:51:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28835 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261835AbVGFNNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 09:13:37 -0400
Subject: Re: PROBLEM: please remove reserved word "new" from kernel headers
From: David Woodhouse <dwmw2@infradead.org>
To: Rob Prowel <tempest766@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050706092657.95280.qmail@web60012.mail.yahoo.com>
References: <20050706092657.95280.qmail@web60012.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 06 Jul 2005 14:14:24 +0100
Message-Id: <1120655664.19467.271.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-06 at 02:26 -0700, Rob Prowel wrote:
> While not an error, per se, it is kind of sloppy and
> it is amazing that it hasn't shown up before now. 
> using the identifier "new" in kernel headers that are
> visible to applications programs is a bad idea.

It _is_ an error, on mysql's part. The kernel headers are _not_ intended
to be visible to applications, in the general case. Why is mysql
including this header? 

-- 
dwmw2

