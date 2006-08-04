Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161056AbWHDJHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbWHDJHf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 05:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbWHDJHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 05:07:35 -0400
Received: from canuck.infradead.org ([205.233.218.70]:16094 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1161056AbWHDJHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 05:07:35 -0400
Subject: Re: [PATCH] MTD jedec_probe: Recognize Atmel AT49BV6416
From: David Woodhouse <dwmw2@infradead.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060804105220.6d125976@cad-250-152.norway.atmel.com>
References: <11546801142874-git-send-email-hskinnemoen@atmel.com>
	 <1154680798.31031.179.camel@shinybook.infradead.org>
	 <20060804105220.6d125976@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 17:06:19 +0800
Message-Id: <1154682379.31031.190.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 10:52 +0200, Haavard Skinnemoen wrote:
> It is actually a CFI chip. But I couldn't figure out how to install the
> fixup in the other patch in the CFI code. The AT49BV6416 chip
> identifies itself as using the AMD command set, so the fixup must be
> installed based on the jedec ID... 

Er, note that the _correct_ answer is to advertise the availability of
the lock functionality in the CFI 'extended query' information. Did the
hardware designer screw that up?

-- 
dwmw2

