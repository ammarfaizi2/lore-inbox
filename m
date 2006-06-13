Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWFMNPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWFMNPw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 09:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWFMNPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 09:15:52 -0400
Received: from lucidpixels.com ([66.45.37.187]:23705 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932089AbWFMNPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 09:15:51 -0400
Date: Tue, 13 Jun 2006 09:15:50 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Matthias Andree <matthias.andree@gmx.de>
cc: Bernd Petrovitsch <bernd@firmix.at>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       marty fouts <mf.danger@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
In-Reply-To: <20060613105021.GB13597@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.64.0606130915090.8834@p34.internal.lan>
References: <200606130305.k5D35YhA004268@laptop11.inf.utfsm.cl>
 <1150187478.28123.7.camel@tara.firmix.at> <20060613105021.GB13597@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Jun 2006, Matthias Andree wrote:

> Bernd Petrovitsch schrieb am 2006-06-13:
>
>> On Mon, 2006-06-12 at 23:05 -0400, Horst von Brand wrote:
>>> Bernd Petrovitsch <bernd@firmix.at> wrote:
>> [...]
>>>> Use secure authenticated mail submission on a known good MTA of said
>>>> domain (and even the smallest ISP should be able to set that up).
>>>
>>> So what? What should me make me trust some domain that I've never before
>>
>> Well, so everyone can send email through an MTA (the email accounts
>> "home MTA") covered in the SPF records.
>
> As (1) SPF this is demonstrably useless to establish trust and (2) the
> argument that SPF doesn't provide the required blacklist information
> hasn't been countered yet, it follows that
> SPF just makes life harder for everyone without real benefits in return.
>
> SPF also prefers end-to-end mailings and falls short when relays are
> used - but these are advocated by the SPF disciples.
>
> Can this SPF madness please be buried now?
>
> -- 
> Matthias Andree
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

SPF can be useful though, as a lot of Asian spam, for example says they 
are hotmail.com and they are not, SPF can reject much faster than sender 
address verification.


