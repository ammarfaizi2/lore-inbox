Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWHQLkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWHQLkS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 07:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWHQLkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 07:40:17 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:26536 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964817AbWHQLkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 07:40:16 -0400
Message-ID: <44E4562C.8080304@sw.ru>
Date: Thu, 17 Aug 2006 15:42:36 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 2/7] UBC: core (structures, API)
References: <44E33893.6020700@sw.ru>  <44E33BB6.3050504@sw.ru> <1155747532.24077.382.camel@localhost.localdomain>
In-Reply-To: <1155747532.24077.382.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ar Mer, 2006-08-16 am 19:37 +0400, ysgrifennodd Kirill Korotaev:
> 
>>+ * UB_MAXVALUE is essentially LONG_MAX declared in a cross-compiling safe form.
>>+ */
>>+#define UB_MAXVALUE	( (1UL << (sizeof(unsigned long)*8-1)) - 1)
>>+
> 
> 
> Whats wrong with using the kernels LONG_MAX ?
just historical code line which introduces UB_MAXVALUE independant of
cross-compiler/headers etc.

Will replace it.

Kirill

