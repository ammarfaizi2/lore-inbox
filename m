Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161215AbWGOHIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161215AbWGOHIh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 03:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161248AbWGOHIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 03:08:37 -0400
Received: from canuck.infradead.org ([205.233.218.70]:34701 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1161215AbWGOHIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 03:08:37 -0400
Subject: Re: 2.6.18 Headers - Long
From: David Woodhouse <dwmw2@infradead.org>
To: David Miller <davem@davemloft.net>
Cc: arjan@infradead.org, maillist@jg555.com, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org
In-Reply-To: <20060714.131957.57444250.davem@davemloft.net>
References: <44B7F062.8040102@jg555.com>
	 <1152905987.3159.46.camel@laptopd505.fenrus.org>
	 <1152908202.3191.98.camel@pmac.infradead.org>
	 <20060714.131957.57444250.davem@davemloft.net>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 08:08:14 +0100
Message-Id: <1152947294.3191.103.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 13:19 -0700, David Miller wrote:
> I totally agree.  When I saw that some dists make asm/page.h define
> PAGE_SIZE to "getpagesize()" for userspace, I nearly crapped myself.
> 
> That is insane, and encourages the problem to persist instead of
> encouraging the right fix. 

Until a week or two ago, we had no mechanism with which to implement the
'right fix'. Any distribution taking the initiative and reducing
visibility of stuff like that would be inundated with complaints that
"it works OK on other distributions".

We can be stricter now that we have some expectation of _consistency_
across distributions.

-- 
dwmw2

