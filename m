Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267382AbUIAR63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267382AbUIAR63 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUIARzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 13:55:32 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:61144 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266892AbUIARxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 13:53:17 -0400
Message-ID: <41360C7D.4020009@colorfullife.com>
Date: Wed, 01 Sep 2004 19:53:01 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] remove ptrinfo
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:

>it's defined in slab.c but not used anywhere
>  
>
Correct: ptrinfo is a debug-only function. Intended to be called from 
kgdb stubs or for local printk debugging tests.
I think gdb even allows to call functions while it's stopped on a 
breakpoint.

I added it as an example what slab knows about it's objects - I have 
such test functions in my local files, but most developers don't know 
how slab tracks objects. It's reference code - I'm not sure if it 
belongs into the kernel or not.

--
    Manfred

