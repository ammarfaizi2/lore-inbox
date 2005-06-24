Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262994AbVFXBqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbVFXBqD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 21:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbVFXBqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 21:46:03 -0400
Received: from mail.dvmed.net ([216.237.124.58]:9150 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262994AbVFXBp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 21:45:56 -0400
Message-ID: <42BB65BC.1010703@pobox.com>
Date: Thu, 23 Jun 2005 21:45:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>	 <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB5E1A.70903@namesys.com>
In-Reply-To: <42BB5E1A.70903@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Alan Cox wrote:
>>>Duplication of effort.  With plugins, we can optimize the upper layers
>>>of ALL filesystems, regardless of the lower layers, in such a way that

>>In which case the features belong in the VFS as all those with
>>experience and kernel contributions have been arguing.

> So you fundamentally reject the prototype it in one fs and then abstract
> it to others development model?


For similar reasons, we don't let hardware vendors implement software 
RAID inside the hardware driver.  It's not appropriate at that level.

	Jeff


