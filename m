Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758536AbWK0T3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758536AbWK0T3f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 14:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758524AbWK0T3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 14:29:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37848 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1758529AbWK0T3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 14:29:34 -0500
Message-ID: <456B3B2D.9040302@redhat.com>
Date: Mon, 27 Nov 2006 11:23:25 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
References: <11641265982190@2ka.mipt.ru> <4564E2AB.1020202@redhat.com> <20061123115504.GB20294@2ka.mipt.ru> <4565FDED.2050003@redhat.com> <20061124114614.GA32545@2ka.mipt.ru> <45671E16.6060005@redhat.com> <20061124164916.GA4012@2ka.mipt.ru>
In-Reply-To: <20061124164916.GA4012@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:

> That index is provided by kernel for userspace so that userspace could
> determine where indexes are - of course userspace can maintain it
> itself, but it can also use provided by kernel.

Indeed.  That's what I said.  But I also pointed out that the field is 
only useful in simple minded programs and certainly not in the wrappers 
the runtime (glibc) will provide.

As you said yourself, there is no real need for the value being there, 
userland can keep track of it by itself.  So, let's reduce the interface.


> I do not care actually about that index, but as you have probably noticed, 
> there was such an interface already, and I changed it. So, this will be the 
> last change of the interface. You think it should not be exported -
> fine, it will not be.

Thanks.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
