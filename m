Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWGED65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWGED65 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 23:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWGED65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 23:58:57 -0400
Received: from mail.tmr.com ([64.65.253.246]:5091 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S932367AbWGED64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 23:58:56 -0400
Message-ID: <44AB3988.1050308@tmr.com>
Date: Wed, 05 Jul 2006 00:01:12 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Greg KH <greg@kroah.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>	 <9e0cf0bf0607030304n62991dafk19f09e41d69e9ab0@mail.gmail.com>	 <e1e1d5f40607031104o2b8003c8qfa725ae1d276b27f@mail.gmail.com>	 <44A95F12.8080208@gmail.com>	 <e1e1d5f40607031353l48826d5bi51558d9f8e12ba3@mail.gmail.com>	 <20060703214509.GA5629@kroah.com>	 <e1e1d5f40607031511l5445f338t449bf8840e8caf80@mail.gmail.com> <1151966154.16528.42.camel@localhost.localdomain>
In-Reply-To: <1151966154.16528.42.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Llu, 2006-07-03 am 18:11 -0400, ysgrifennodd Daniel Bonekeeper:
>> That's one problem: I don't want to create one more userspace
>> interface for that. I suppose that all the hundreds of fingerprint
>> readers that ships with a SDK have their own way of doing that.. that
> 
> The very cheap readers all appear to be fairly crude image scanners, and
> they even lack hardware encryption/perturbation so they are actually of
> very limited value.

Crude, like beauty, is in the eye of the beholder. I like hardware which 
does as little as possible because I can then apply the appropriate 
software to the data. I can see that if cost is no object and the 
algorithm is never going to change, I can build all that stuff into the 
device. But I don't need to... as long as I can take the data, pass it 
through a transform, and get out of that a key which works or not, then 
I can do useful things with it.

Useful includes many things. I'm playing with using a combined secret 
and SecureID(tm) to decrypt and boot a virtual machine, such that I can 
do many unrelated things and have reduced chance of "unintended data 
migration." It also allows ad-hoc users (read that as undergrads) given 
a temporary machine fairly easily, visiting professors, etc.

I can see the benefits of having the whole package be a black box, I 
hope I have explained why I find even a dumb scanner useful in some cases.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

