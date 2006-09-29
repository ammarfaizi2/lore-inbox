Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161477AbWI2HdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161477AbWI2HdT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 03:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161475AbWI2HdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 03:33:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52139 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161476AbWI2HdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 03:33:17 -0400
Subject: Re: GPLv3 Position Statement
From: David Woodhouse <dwmw2@infradead.org>
To: tridge@samba.org
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <17692.46192.432673.743783@samba.org>
References: <1159498900.3880.31.camel@mulgrave.il.steeleye.com>
	 <17692.46192.432673.743783@samba.org>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 08:32:53 +0100
Message-Id: <1159515173.3309.373.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-29 at 15:51 +1000, tridge@samba.org wrote:
> I actually think they were already in violation with TiVo version 1,
> as they were using binary kernel modules. Although it is possible to
> have a kernel module which is not a derivative work of the kernel (as
> address space and linking concerns are only "rules of thumb", not true
> tests for a derivative work), I think that their modules were in fact
> pretty clearly derived works. I can say this partly because I have
> disassembled a few of them and looked at them in great detail. 

It's simpler than that. They were in violation even if you don't
consider their module to be a derived work, because they distributed it
as part of a larger whole which was based on Linux -- and thus the GPL
extends to "each and every part regardless of who wrote it."

Binary-only modules on their own are extremely dubious, but binary-only
modules shipped as _part_ of an embedded product, in conjunction with a
Linux kernel, are a clear violation of the licence.



"If identifiable sections of that work are not derived from the Program,
and can be reasonably considered independent and separate works in
themselves, then this License, and its terms, do not apply to those
sections when you distribute them as separate works.  But when you
distribute the same sections as part of a whole which is a work based
on the Program, the distribution of the whole must be on the terms of
this License, whose permissions for other licensees extend to the
entire whole, and thus to each and every part regardless of who wrote
it."

-- 
dwmw2

