Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262715AbVF2XAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbVF2XAH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 19:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVF2XAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 19:00:07 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:8399 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262715AbVF2W7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 18:59:31 -0400
Message-ID: <42C327CF.70408@namesys.com>
Date: Wed, 29 Jun 2005 15:59:27 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, tytso@mit.edu, mjt@nysv.org,
       vonbrand@inf.utfsm.cl, ninja@slaphack.com, alan@lxorguk.ukuu.org.uk,
       jgarzik@pobox.com, hch@infradead.org, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, lord@xfs.org, vs <vs@thebsh.namesys.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Nikita Danilov <Nikita@namesys.com>
Subject: Re: reiser4 merging action list
References: <42BB7B32.4010100@slaphack.com>	 <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl>	 <20050627092138.GD11013@nysv.org> <20050627124255.GB6280@thunk.org>	 <42C0578F.7030608@namesys.com> <20050627212628.GB27805@thunk.org>	 <42C084F1.70607@namesys.com> <20050627162303.156551b4.akpm@osdl.org>	 <42C2348F.3000908@namesys.com> <84144f02050628231814e9e6db@mail.gmail.com>
In-Reply-To: <84144f02050628231814e9e6db@mail.gmail.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:

>Andrew Morton wrote:
>  
>
>>>There's also the custom list, hash and debug code.  We should either
>>>
>>>a) remove them or
>>>
>>>b) generify them and submit as standalone works or
>>>
>>>c) justify them as custom-to-reiser4 and leave them as-is.
>>>      
>>>
>
>On 6/29/05, Hans Reiser <reiser@namesys.com> wrote:
>  
>
>>either b) or c) is ok with me for the list code.  The debug code should
>>be c) I think.
>>
>>Probably vs can offer a more detailed and accurate opinion,
>>    
>>
>
>I completely agree that the current state of the generic hashing
>facilities is somewhat poor but I fail to see why you can't use
><linux/list.h>.
>  
>
I'll let vs and maybe nikita comment.

>As for the debugging code, I would love to see that turned into
>something generic (every subsystem has their own now) but it is
>definitely not something that should stop you from merging.
>
>                                Pekka
>
>
>  
>
If I encourage you to make a patch, is that ok of me? 
