Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVEXPgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVEXPgh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVEXPge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:36:34 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:65432 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262112AbVEXPfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:35:10 -0400
Message-ID: <429349A0.90305@yahoo.com.au>
Date: Wed, 25 May 2005 01:34:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Voluntary Kernel Preemption, 2.6.12-rc4-mm2
References: <20050524121541.GA17049@elte.hu>	 <20050524132105.GA29477@elte.hu> <20050524145636.GA15943@infradead.org>	 <20050524150950.GA10736@elte.hu>  <4293466B.5070200@yahoo.com.au> <1116948792.6280.26.camel@laptopd505.fenrus.org>
In-Reply-To: <1116948792.6280.26.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2005-05-25 at 01:21 +1000, Nick Piggin wrote:
> 
>>IIRC, the reason (when you wrote the code) was that you didn't
>>want to enable preempt either because of binary compatibility, or
>>because of bugs? Well I think the bug issue is no more since your
>>debug patches went in, and the compatibility reason may be a fine
>>one for a distro kernel, but not a kernel.org one.
> 
> 
> I can't imagine binary compatibility having been a reason. At least for
> the RH distros it really isn't kernel wise. At All.
> PREEMPT was (and is?) a stability risk and so you'll see RHEL4 not
> having it enabled. But it has nothing to do with in-kernel binary
> compatibility; that just doesn't exist, kernel.org or distro alike.
> 

Yeah that was the reason.

