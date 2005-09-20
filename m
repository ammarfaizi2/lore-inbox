Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbVITH71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbVITH71 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 03:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbVITH70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 03:59:26 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:54975 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964917AbVITH70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 03:59:26 -0400
Message-ID: <432FC150.9020807@namesys.com>
Date: Tue, 20 Sep 2005 00:59:12 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       lkml <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <432AFB44.9060707@namesys.com>	 <200509171415.50454.vda@ilport.com.ua>	 <200509180934.50789.chriswhite@gentoo.org>	 <200509181321.23211.vda@ilport.com.ua>	 <20050918102658.GB22210@infradead.org>	 <b14e81f0050918102254146224@mail.gmail.com>	 <1127079524.8932.21.camel@localhost.localdomain>	 <432E4786.7010001@namesys.com> <432F8D1E.7060300@yahoo.com.au>	 <432FABFA.9010406@namesys.com> <1127200590.9436.15.camel@npiggin-nld.site>
In-Reply-To: <1127200590.9436.15.camel@npiggin-nld.site>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

>On Mon, 2005-09-19 at 23:28 -0700, Hans Reiser wrote:
>  
>
>>Nick Piggin wrote:
>>    
>>
>
>  
>
>>>What's wrong with the elevator code?
>>>
>>>      
>>>
>>The name for one.  There is no elevator algorithm anywhere in it.  There
>>is a least block number first algorithm that was called an elevator, but
>>    
>>
>
>Well the terminology changed to "io scheduler" now, however the
>residual "elevator" name found in places doesn't cause anyone
>any problems and there isn't much reason to change it other than
>the desire to break things.
>  
>
Did you really say that?    I mean, come on, can't you at least manage a
"well, it ought to get changed but I am busy with something more
exciting to me".

>  
>
>>it does not have the properties described by Ousterhout and sundry CS
>>textbooks describing elevator algorithms.  The textbook algorithms are
>>better than least block number first, and it is interesting how nobody
>>fixed the mislabeling of the algorithm once Linux had gotten to the
>>point that it was striving for more than making gcc be able to run on it. 
>>
>>    
>>
>
>There is no least block number first io scheduler now. And the
>deadline scheduler is basically an elevator algorithm with
>deadlines.
>  
>
Ask Nate about this after he gets an ok from the customer to disclose
his work.  It is not so simple as you claim.

>  
>
>>cfq is good code though for many usage patterns. 
>>
>>    
>>
>
>But that is not a true elevator algorithm either... so what are
>you trying to say?
>  
>
I am trying to be balanced.  2.6 was a dramatic improvement over 2.4,
and cfq seems to work well.

>But if you really need to , I instead suggest badmouthing devfs.
>That is sure to get you on the good side of the VFS guys! :)
>  
>
Devfs was a good idea in its essence.  http://kerneltrap.org/node/5665
suggests pretty clearly that the hostility of the VFS guys caused no one
to want to invest enough into devfs to make it viable compared to udev.

They were inappropriately nasty to Mr. Gooch, who was kind enough to
contribute an idea that Linux needed.  They could have been helpful and
assisting, and instead they were the opposite.  As they are with everyone.
