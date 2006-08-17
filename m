Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWHQAF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWHQAF6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 20:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWHQAF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 20:05:58 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49871 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932144AbWHQAF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 20:05:58 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting
	(core)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: rohitseth@google.com, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1155758369.9274.26.camel@localhost.localdomain>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
	 <1155755729.22595.101.camel@galaxy.corp.google.com>
	 <1155758369.9274.26.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Aug 2006 01:24:34 +0100
Message-Id: <1155774274.15195.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-16 am 12:59 -0700, ysgrifennodd Dave Hansen:
> relationship between processes and mm's.  We could also potentially have
> two different threads of a process in two different accounting contexts.
> But, that might be as simple to fix as disallowing things that share mms
> from being in different accounting contexts, unless you unshare the mm.

At the point I have twenty containers containing 20 copies of glibc to
meet your suggestion it would be *far* cheaper to put it in the page
struct.

Alan

