Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755102AbWKVMeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102AbWKVMeN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 07:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755110AbWKVMeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 07:34:13 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:9611 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1755096AbWKVMeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 07:34:12 -0500
Message-ID: <456443AA.7060106@garzik.org>
Date: Wed, 22 Nov 2006 07:33:46 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Ulrich Drepper <drepper@redhat.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
References: <11630606361046@2ka.mipt.ru> <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <45622228.80803@garzik.org> <456223AC.5080400@redhat.com> <456436CA.7050809@tls.msk.ru>
In-Reply-To: <456436CA.7050809@tls.msk.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> Can't the argument be something like u64 instead of struct timespec,
> regardless of this discussion (relative vs absolute)?


Newer syscalls (ppoll, pselect) take struct timespec, which is a 
reasonable, modern form of the timeout argument...

	Jeff


