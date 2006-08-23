Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWHWJVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWHWJVH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 05:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWHWJVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 05:21:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:60878 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751473AbWHWJVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 05:21:05 -0400
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] paravirt.h
Date: Wed, 23 Aug 2006 11:20:42 +0200
User-Agent: KMail/1.9.3
Cc: Arjan van de Ven <arjan@infradead.org>, virtualization@lists.osdl.org,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1155202505.18420.5.camel@localhost.localdomain> <200608231106.26696.ak@suse.de> <44EC1C7C.9020304@vmware.com>
In-Reply-To: <44EC1C7C.9020304@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608231120.42679.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I need to look at the kprobes code in more depth to answer completely.  
> But in general, there could be a problem if DRs are set to fire on any 
> EIP 

kprobes don't use DRs.

-Andi
