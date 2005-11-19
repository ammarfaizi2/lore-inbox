Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbVKSMAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVKSMAY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 07:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVKSMAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 07:00:23 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:46468 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751088AbVKSMAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 07:00:23 -0500
Message-ID: <437F13C7.8040100@colorfullife.com>
Date: Sat, 19 Nov 2005 13:00:07 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, colpatch@us.ibm.com
Subject: Re: [PATCH 2/5] slab: remove unused align parameter from alloc_percpu
References: <iq5uu6.r1w80m.fi2lra14o0wdqqk5ln4hwlcm.beaver@cs.helsinki.fi>
In-Reply-To: <iq5uu6.r1w80m.fi2lra14o0wdqqk5ln4hwlcm.beaver@cs.helsinki.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:

>__alloc_percpu and alloc_percpu both take an 'align' argument which is
>completely ignored.  snmp6_mib_init() in net/ipv6/af_inet6.c attempts to
>use it, but it will be ignored.  Therefore, remove the 'align' argument
>and fixup the lone caller.
>
>Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>
>Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
>  
>
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>

