Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbUCJVAc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262833AbUCJVAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:00:25 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:12743 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262820AbUCJU55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:57:57 -0500
Message-ID: <404F814C.1070202@colorfullife.com>
Date: Wed, 10 Mar 2004 21:57:48 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] different proposal for mq_notify(SIGEV_THREAD)
References: <404B2C46.90709@colorfullife.com> <20040310203857.GA7341@mail.shareable.org>
In-Reply-To: <20040310203857.GA7341@mail.shareable.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

>The difference is that your proposal eliminates those fds.
>But there is no reason that I can see why mq_notify() should be
>optimised in this way and futexes not.
>  
>
I would start with message queues, but the mechanism must be generic 
enough to be used for futexes, etc.

The main open question is if I should write something new or if I can 
reuse netlink.

--
    Manfred

