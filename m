Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbTLMWg0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 17:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265316AbTLMWg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 17:36:26 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:24519 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265314AbTLMWgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 17:36:25 -0500
Message-ID: <3FDB9462.4060402@colorfullife.com>
Date: Sat, 13 Dec 2003 23:36:18 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Use-after-free in pte_chain in 2.6.0-test11
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Slab corruption: start=da54d380, expend=da54d3ff, problemat=da54d3fc
>Data: ******************************************************************************** \
>                ********************************************6A **A5
>
"*" stands for 0x6b, and the pte chain contains pointers, not bits. It 
looks like bad memory.

--
    Manfred

