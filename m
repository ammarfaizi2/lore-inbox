Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbVIBMoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVIBMoA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 08:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVIBMoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 08:44:00 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:60373 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751297AbVIBMn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 08:43:59 -0400
Subject: Re: [PATCH 2.6.13] lockless pagecache 2/7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4317F136.4040601@yahoo.com.au>
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au>
	 <4317F136.4040601@yahoo.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 02 Sep 2005 14:08:06 +0100
Message-Id: <1125666486.30867.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-09-02 at 16:29 +1000, Nick Piggin wrote:
> 2/7
> Implement atomic_cmpxchg for i386 and ppc64. Is there any
> architecture that won't be able to implement such an operation?

i386, sun4c, ....

Yeah quite a few. I suspect most MIPS also would have a problem in this
area.

