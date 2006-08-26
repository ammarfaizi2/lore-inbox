Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWHZQRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWHZQRN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 12:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWHZQRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 12:17:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5015 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030231AbWHZQRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 12:17:12 -0400
Subject: Re: BC: resource beancounters (v2)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: rohitseth@google.com
Cc: Andrey Savochkin <saw@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, devel@openvz.org,
       Rik van Riel <riel@redhat.com>, Andi Kleen <ak@suse.de>,
       Greg KH <greg@kroah.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Matt Helsley <matthltc@us.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
In-Reply-To: <1156558552.24560.23.camel@galaxy.corp.google.com>
References: <44EC31FB.2050002@sw.ru> <20060823100532.459da50a.akpm@osdl.org>
	 <44EEE3BB.10303@sw.ru> <20060825073003.e6b5ae16.akpm@osdl.org>
	 <20060825203026.A16221@castle.nmd.msu.ru>
	 <1156558552.24560.23.camel@galaxy.corp.google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 26 Aug 2006 17:37:03 +0100
Message-Id: <1156610224.3007.284.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-25 am 19:15 -0700, ysgrifennodd Rohit Seth:
> Yes, sharing of pages across different containers/managers will be a
> problem.  Why not just disallow that scenario (that is what fake nodes
> proposal would also end up doing).

Because it destroys the entire point of using containers instead of
something like Xen - which is sharing. Also at the point I am using
beancounters per user I don't want glibc per use, libX11 per use glib
per use gtk per user etc..


