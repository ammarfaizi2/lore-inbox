Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267232AbUJBClT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267232AbUJBClT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 22:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267235AbUJBClT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 22:41:19 -0400
Received: from mail-12.iinet.net.au ([203.59.3.44]:7143 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267232AbUJBClR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 22:41:17 -0400
Message-ID: <415E154A.2040209@cyberone.com.au>
Date: Sat, 02 Oct 2004 12:41:14 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-mm@kvack.org, akpm@osdl.org, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
References: <20041001182221.GA3191@logos.cnet>
In-Reply-To: <20041001182221.GA3191@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo Tosatti wrote:

>
>For example it doesnt re establishes pte's once it has unmapped them.
>
>

Another thing - I don't know if I'd bother re-establishing ptes....
I'd say just leave it to happen lazily at fault time.

