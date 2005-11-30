Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVK3IUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVK3IUN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 03:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVK3IUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 03:20:13 -0500
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:40050 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751124AbVK3IUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 03:20:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=kVARTwdU8QYrMtte5WCdxRztxP3h/+0KUxzEWeyCguJMKgYBX3vf/mVRrCRuzzYmSSw34ZZ4ZqbcI8Ctfyf1ufhRfeBlQ7a8nJnHG2G4qhRtUwixzD6/M5dqioXO0cBvHyHx/nVQY+QA5Tj8YLG7/NRxagssrEycDKe1+RdWmmQ=  ;
Message-ID: <438D60B0.4020207@yahoo.com.au>
Date: Wed, 30 Nov 2005 19:20:00 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Jari Ruusu <jariruusu@users.sourceforge.net>,
       Benjamin LaHaise <bcrl@kvack.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] x86-64 put current in r10
References: <20051130042118.GA19112@kvack.org>	 <438D4905.9F023405@users.sourceforge.net> <1133337416.2825.18.camel@laptopd505.fenrus.org>
In-Reply-To: <1133337416.2825.18.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2005-11-30 at 08:39 +0200, Jari Ruusu wrote:
> 
>>Benjamin LaHaise wrote:
>>
>>>The following emails contain the patches to convert x86-64 to store current
>>>in r10 (also at http://www.kvack.org/~bcrl/patches/v2.6.15-rc3/).
>>
>>[snip]
>>
>>>No benchmarks that I am aware of show regressions with this change.
>>
>>Ben,
>>Your patch breaks all out-of-tree amd64 assembler code used in kernel. 
> 
> 
> so what?
> 

Sounds like a trick question - I don't think the kernel does use any
out-of-tree amd64 assember code, does it? ;)

Send instant messages to your online friends http://au.messenger.yahoo.com 
