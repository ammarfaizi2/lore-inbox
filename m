Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbTESSLE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbTESSLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:11:03 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:55183 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S262620AbTESSKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:10:54 -0400
Message-ID: <3EC9212C.4070303@blue-labs.org>
Date: Mon, 19 May 2003 14:23:40 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030518
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Christoph Hellwig <hch@infradead.org>,
       Martin Schlemmer <azarah@gentoo.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <1053289316.10127.41.camel@nosferatu.lan>	 <20030518204956.GB8978@holomorphy.com>	 <1053292339.10127.45.camel@nosferatu.lan>	 <20030519063813.A30004@infradead.org>	 <1053341023.9152.64.camel@workshop.saharact.lan>	 <20030519124539.B8868@infradead.org>  <3EC91B6D.9070308@blue-labs.org> <1053367592.1424.8.camel@laptop.fenrus.com>
In-Reply-To: <1053367592.1424.8.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't miss the point.  I don't use RH, and I'm not in a mood to 
switch to RH just because RH has an LK headers maintainer.

The question is how to make these headers.  Who decides what should and 
shouldn't be available to userland?  What of the myriad of tools which 
make modules, or use deep kernel headers?  What of the packages that try 
hard to keep subset headers synchronized but get frustrated because 
update patches get dropped?  What am I supposed to do when I want to use 
several of these packages and their updates conflict with each other?

AFAIK, you don't have a package that contains all the -current- headers 
for all the current versions of all these various projects applied to 
the kernel headers and then sanitized.  I want to use my hardware that 
is supported by version X of the package's software but the headers only 
have version M supported.  Wireless extensions for example.

With everybody maintaining separate headers things get messy.

The question is how to make these headers.  Nobody wants to say how and 
when someone needs an answer, even a distro maintainer, the answer is a 
flippant "don't use kernel headers / use your vendor".  I haven't seen 
otherwise and believe me, I would latch on to the answer because I'm 
always having to tailer headers to make things work for a variety of 
distributions.

David

Arjan van de Ven wrote:

>On Mon, 2003-05-19 at 19:59, David Ford wrote:
>
>  
>
>>Someone please step up to the plate and explain how to convert kernel 
>>headers into sanitized headers for /usr/include.
>>    
>>
>
>It seems you totally miseed the entire point.
>It shouldn't be an automatic conversion. It should be a well thought
>subset cleaned from kernel private stuff.
>
>I maintain such a subset for my employer and it's free for all to use
>(it's GPL after all). 
>  
>


