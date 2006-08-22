Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWHVTaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWHVTaY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWHVTaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:30:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41938 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750701AbWHVTaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:30:21 -0400
Subject: Re: [PATCH] paravirt.h
From: Arjan van de Ven <arjan@infradead.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
       virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <44EB5A76.9060402@vmware.com>
References: <1155202505.18420.5.camel@localhost.localdomain>
	 <44DB7596.6010503@goop.org>
	 <1156254965.27114.17.camel@localhost.localdomain>
	 <200608221544.26989.ak@muc.de>  <44EB3BF0.3040805@vmware.com>
	 <1156271386.2976.102.camel@laptopd505.fenrus.org>
	 <1156275004.27114.34.camel@localhost.localdomain>
	 <44EB584A.5070505@vmware.com>  <44EB5A76.9060402@vmware.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 22 Aug 2006 21:29:43 +0200
Message-Id: <1156274983.2976.111.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That is a really nasty problem.  You need a synchronization primitive 
> which guarantees a flat stack, so you can't do it in the interrupt 
> handler as I have tried to do.  I'll bang my head on it awhile.  In the 
> meantime, were there ever any solutions to the syscall patching problem 
> that might lend me a clue as to what to do (or not to do, or impossible?).

yes we just disallowed it :)


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

