Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWHCUoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWHCUoZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWHCUoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:44:25 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60373 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751324AbWHCUoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:44:23 -0400
Subject: Re: A proposal - binary
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zachary Amsden <zach@vmware.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
In-Reply-To: <44D23B84.6090605@vmware.com>
References: <44D1CC7D.4010600@vmware.com>
	 <1154603822.2965.18.camel@laptopd505.fenrus.org>
	 <44D23B84.6090605@vmware.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Aug 2006 22:03:37 +0100
Message-Id: <1154639017.23655.121.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-03 am 11:08 -0700, ysgrifennodd Zachary Amsden:
> encourage open sourced firmware layers, instead of trying to ban drivers 
> which rely on firmware from the kernel.

The reasons for pushing downloadable firmware out of the kernel are
manyfold and based on legal advice.

MORAL:  Many free software people like a clean separation between the
free and non-free components of a system

LEGAL:	Some firmware isn't publically redistributable but comes with the
h/w

LEGAL:	Several lawyers have advised people that putting firmware
separate to the kernel is different to embedding it in kernel in terms
of the derivative work question. 

TECHNICAL:  Unswappable blobs of kernel memory taken up by firmware is
bad generally speaking

TECHNICAL:  Pulling 20Mb of unchanging firmware each kernel tree is
annoying


