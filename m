Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbULERIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbULERIs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 12:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbULERGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 12:06:33 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:37778 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261330AbULEQ7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 11:59:48 -0500
Message-ID: <41B33E70.2000107@colorfullife.com>
Date: Sun, 05 Dec 2004 17:59:28 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Stuff <kernel-stuff@comcast.net>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] Document kfree and vfree NULL usage (resend)
References: <Pine.LNX.4.44.0412051628280.13644-100000@dbl.q-ag.de> <200412051105.10934.kernel-stuff@comcast.net>
In-Reply-To: <200412051105.10934.kernel-stuff@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Stuff wrote:

>>  *	May not be called in interrupt context 
>>    
>>
>Does this need to change to 
>      * Must not be called in interrupt context 
>?
>Is there a case where it is guaranteed that kfree will not sleep?
>
kfree never sleeps. The comment you mention is part of the vfree 
documentation.

And you are right: for vfree, it's "must not be called". I'll send a 
separate patch. Or Andrew could just change it directly.

--
    Manfred
