Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267520AbUIGKqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267520AbUIGKqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 06:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267558AbUIGKqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 06:46:54 -0400
Received: from mail-13.iinet.net.au ([203.59.3.45]:30883 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267520AbUIGKqm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 06:46:42 -0400
Message-ID: <413D8FB2.1060705@cyberone.com.au>
Date: Tue, 07 Sep 2004 20:38:42 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       raybry@sgi.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       riel@redhat.com, mbligh@aracnet.com
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
References: <413CB661.6030303@sgi.com> <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <cone.1094513660.210107.6110.502@pc.kolivas.org> <20040907000304.GA8083@logos.cnet>
In-Reply-To: <20040907000304.GA8083@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo Tosatti wrote:

>
>Hi kernel fellows,
>
>I volunteer. I'll try something tomorrow to compare swappiness of older kernels like  
>2.6.5 and 2.6.6, which were fine on SGI's Altix tests, up to current newer kernels 
>(on small memory boxes of course).
>

Hi Marcelo,

Just a suggestion - I'd look at the thrashing control patch first.
I bet that's the cause.

