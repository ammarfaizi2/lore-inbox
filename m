Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWH2KfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWH2KfT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 06:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWH2KfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 06:35:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10461 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751010AbWH2KfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 06:35:17 -0400
Subject: Re: [Devel] Re: BC: resource beancounters (v2)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: rohitseth@google.com
Cc: Kir Kolyshkin <kir@openvz.org>, devel@openvz.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Chandra Seetharaman <sekharan@us.ibm.com>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <1156804089.8985.19.camel@galaxy.corp.google.com>
References: <44EC31FB.2050002@sw.ru> <20060823100532.459da50a.akpm@osdl.org>
	 <44EEE3BB.10303@sw.ru> <20060825073003.e6b5ae16.akpm@osdl.org>
	 <20060825203026.A16221@castle.nmd.msu.ru>
	 <1156558552.24560.23.camel@galaxy.corp.google.com>
	 <1156610224.3007.284.camel@localhost.localdomain>
	 <1156783721.8317.6.camel@galaxy.corp.google.com>
	 <44F32AC7.1090604@openvz.org>
	 <1156804089.8985.19.camel@galaxy.corp.google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 29 Aug 2006 11:15:35 +0100
Message-Id: <1156846535.6271.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-28 am 15:28 -0700, ysgrifennodd Rohit Seth:
> Though if we have file/directory based accounting then shared pages
> belonging to /usr/lib or /usr/bin can go to a common container.

So that one user can map all the spare libraries and config files and
DoS the system by preventing people from accessing the libraries they do
need ?

