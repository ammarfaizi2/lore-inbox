Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267518AbUH0TWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267518AbUH0TWw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 15:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267354AbUH0TSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 15:18:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4746 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267421AbUH0TNl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:13:41 -0400
Message-ID: <412F87D8.6020009@pobox.com>
Date: Fri, 27 Aug 2004 15:13:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Peck <coderman@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: faster via/centaur hw rng throughput patch for 2.6.8.1
References: <4ef5fec604082711523b3935f9@mail.gmail.com>
In-Reply-To: <4ef5fec604082711523b3935f9@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peck wrote:
> i have prepared a hw_random.c patch for the via / centaur C5P
> processor entropy sources which utilizes module parameters to
> achieve significant increases in throughput.


hmmmm.

Honestly I would rather just remove the VIA support from the kernel 
completely:  it belongs in the userspace rngd 
(http://sf.net/projects/gkernel/)

I've been meaning to do this for a while, wanna volunteer?  ;-)

The current code is stable and doesn't need module parameters, so I 
would prefer to just modify userspace rngd instead.

	Jeff


