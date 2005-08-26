Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbVHZRQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbVHZRQz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbVHZRQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:16:55 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:27852 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S965126AbVHZRQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:16:54 -0400
Message-ID: <430F4E57.3000001@colorfullife.com>
Date: Fri, 26 Aug 2005 19:16:07 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pipe: do not return POLLERR for fifo_poll
References: <ilomk8.i0yljb.2ul6sqfgelx5ik5dngkbmbkeu.beaver@cs.helsinki.fi> <ilomki.fs3loe.5j02sm6rx63x13ip2d9643lta.beaver@cs.helsinki.fi> <20050825170217.666edda3.akpm@osdl.org> <Pine.LNX.4.58.0508261000310.26177@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0508261000310.26177@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:

>FWIW I have been running on this for few days now without any noticeable 
>regressions.  We get a solved FIXME in return but like I said I am a happy 
>to remove the redundant abstraction if this is too risky.
>
>  
>
I would prefer just to remove the abstraction, together with a comment 
that Linux fifos behave exactly like pipes, unlike the behavior of most 
unices.

--
    Manfred
