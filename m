Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWBVUVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWBVUVv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWBVUVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:21:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21958 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751420AbWBVUVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:21:51 -0500
Subject: Re: Problem with NETIF_F_HIGHDMA
From: Arjan van de Ven <arjan@infradead.org>
To: Corey Minyard <minyard@acm.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43FCC62A.4070704@acm.org>
References: <43FCB1B3.8090101@acm.org>
	 <1140634261.2979.59.camel@laptopd505.fenrus.org> <43FCC62A.4070704@acm.org>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 21:21:45 +0100
Message-Id: <1140639706.2979.75.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 14:14 -0600, Corey Minyard wrote:

> >you use the PCI mapping api right? if you do that then there's no
> >problem, after pci mapping the addresses will be in the lower address
> >range perfectly fine....
> >  
> >
> Ah, cool, physical memory remapping.  Then the problem lies elsewhere. 
> Thanks.

iommu's are cool things ;)


