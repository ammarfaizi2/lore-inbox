Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbWHWRMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbWHWRMV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 13:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbWHWRMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 13:12:21 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5289 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965072AbWHWRMU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 13:12:20 -0400
Subject: Re: [PATCH 4/6] BC: user interface (syscalls)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Kirill Korotaev <dev@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
In-Reply-To: <20060823095031.cb14cc52.akpm@osdl.org>
References: <44EC31FB.2050002@sw.ru> <44EC369D.9050303@sw.ru>
	 <44EC5B74.2040104@sw.ru>  <20060823095031.cb14cc52.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 23 Aug 2006 18:29:42 +0100
Message-Id: <1156354182.3007.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-23 am 09:50 -0700, ysgrifennodd Andrew Morton:
> On Wed, 23 Aug 2006 17:43:16 +0400
> Kirill Korotaev <dev@sw.ru> wrote:
> 
> > +asmlinkage long sys_set_bclimit(uid_t id, unsigned long resource,
> > +		unsigned long *limits)
> 
> I'm still a bit mystified about the use of uid_t here.  It's not a uid, is
> it?

Its a uid_t because of setluid() and twenty odd years of existing unix
practice. 

Alan

