Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbVKHUBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbVKHUBV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 15:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbVKHUBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 15:01:21 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:27099 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S964973AbVKHUBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 15:01:21 -0500
Message-ID: <437103BB.2000209@colorfullife.com>
Date: Tue, 08 Nov 2005 20:59:55 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Dobson <colpatch@us.ibm.com>
CC: Christoph Lameter <clameter@engr.sgi.com>,
       Roland Dreier <rolandd@cisco.com>, kernel-janitors@lists.osdl.org,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] Cleanup kmem_cache_create()
References: <436FF51D.8080509@us.ibm.com> <436FF70D.6040604@us.ibm.com> <52mzkfrily.fsf@cisco.com> <Pine.LNX.4.62.0511081049520.30907@schroedinger.engr.sgi.com> <4370F6BB.1070409@us.ibm.com> <Pine.LNX.4.62.0511081108340.31060@schroedinger.engr.sgi.com> <4370FA9F.6010800@us.ibm.com>
In-Reply-To: <4370FA9F.6010800@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:

>Manfred, any reason not to name this constant in slab.c?  If there's a good
>reason not to, I'm perfectly happy to leave it alone. :)
>
>  
>
No, there is no reason. It's debug-only code, thus I was too lazy to 
create a constant.

And no - don't make me maintainer of slab.c. I didn't even have enough 
time to review the numa patches properly.

--
    Manfred
