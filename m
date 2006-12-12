Return-Path: <linux-kernel-owner+w=401wt.eu-S1751336AbWLLNjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWLLNjt (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 08:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWLLNjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 08:39:48 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:55574 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336AbWLLNjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 08:39:47 -0500
Message-ID: <457EB115.3020407@garzik.org>
Date: Tue, 12 Dec 2006 08:39:33 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Subject: Re: [take26-resend1 0/8] kevent: Generic event handling mechanism.
References: <1165848619971@2ka.mipt.ru> <457D764E.9040308@garzik.org> <20061212053902.GC14420@2ka.mipt.ru>
In-Reply-To: <20061212053902.GC14420@2ka.mipt.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Mon, Dec 11, 2006 at 10:16:30AM -0500, Jeff Garzik (jeff@garzik.org) wrote:
>> Comments:
>>
>> * [oh, everybody will hate me for saying this, but...]  to me, "kevent" 
>> implies an internal kernel subsystem.  I would rather call it "uevent" 
>> or anything else lacking a 'k' prefix.
> 
> It is kernel subsystem indeed, which exports some of its part to
> userspace.
> I previously thought that prefix 'k' can only be confused with KDE.

It is a true statement to say "without the kevent subsystem, userspace 
lacks uevent handling".

And let's be honest, the main consumers of this will be userspace apps, 
and a few in-kernel users pretending to be userspace apps (kernel threads).

	Jeff



