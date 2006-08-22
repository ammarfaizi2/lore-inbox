Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWHVSaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWHVSaV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 14:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWHVSaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 14:30:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41155 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750718AbWHVSaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 14:30:20 -0400
Subject: Re: [PATCH] paravirt.h
From: Arjan van de Ven <arjan@infradead.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <44EB3BF0.3040805@vmware.com>
References: <1155202505.18420.5.camel@localhost.localdomain>
	 <44DB7596.6010503@goop.org>
	 <1156254965.27114.17.camel@localhost.localdomain>
	 <200608221544.26989.ak@muc.de>  <44EB3BF0.3040805@vmware.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 22 Aug 2006 20:29:45 +0200
Message-Id: <1156271386.2976.102.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And it doesn't work for VMI or lhype, both of which might modify 
> paravirt_ops way later in the boot process, when loaded as a module.  

doesn't this then start to have the same issues that runtime patching
the system call table had?

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

