Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265675AbUBKTNa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 14:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbUBKTNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 14:13:30 -0500
Received: from porch.xs4all.nl ([80.126.78.181]:43793 "EHLO porch.xs4all.nl")
	by vger.kernel.org with ESMTP id S265675AbUBKTNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 14:13:13 -0500
Message-ID: <402A7EC6.7010003@nl.tiscali.com>
Date: Wed, 11 Feb 2004 20:13:10 +0100
From: Mark de Vries <m.devries@nl.tiscali.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: About highmem in 2.6
References: <1o6EZ-2zO-27@gated-at.bofh.it> <1o7AZ-3PD-9@gated-at.bofh.it>
In-Reply-To: <1o7AZ-3PD-9@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken wrote:
> --On Wednesday, February 11, 2004 18:47:04 +0100 Luis Miguel García
> <ktech@wanadoo.es> wrote:
> 
> 
>>When I first installed 2.4, someone told me that if I had 1 gb ram it was
>>better to not use highmem because those extra aditional mb was not worth
>>the speed penalty of using the feature.
>>
>>Sorry for my ignorance (and my sucking english) but must I enable highmem
>>now with 2.6? or have it any speed penalty althought?
> 
> 
> I don't know if anyone has actually measured the relative performance, but
> I'd expect the answer to be the same as 2.4.  There is a small but
> measurable performance penalty for enabling highmem which is higher than
> the benefit of the extra 128 meg of memory you get when you have 1G.  If
> you have more than 1G it's better to enable highmem.
> 

I've been using this patch for a while now on my box (with 1GB):
http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23aa1/00_3.5G-address-space-5
(kernel is 'vanilla' otherwise)

This allows you to use your full 1GB w/out highmem support.... (2G/2G 
user/kernel addr space split, or something..)

Anything (potentially) wrong/bad about this patch??

Is there a simmilar patch for 2.6??

Rgds,
Mark.

pls. CC in reply, I'm not on the list....
