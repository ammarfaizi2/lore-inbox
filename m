Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUBQPb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 10:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUBQPb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 10:31:56 -0500
Received: from [195.23.16.24] ([195.23.16.24]:52954 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S266249AbUBQPbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 10:31:55 -0500
Message-ID: <40323395.6060803@grupopie.com>
Date: Tue, 17 Feb 2004 15:30:29 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
Cc: Nischal Saxena <nischal_saxena@da-iict.org>, linux-kernel@vger.kernel.org
Subject: Re: transferring data through the sound card
References: <200402161800.i1GI0ul15334@mail.da-iict.org> <20040216221130.GE18853@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

> Nischal Saxena wrote:
> 
>> how is it possible to transfer data across two PC using the sound card.
>>
> 
> It's possible using a software modem, but it's much easier to use a
> network card instead :)
> 


Since Nischal didn't specify which port on the sound card he was thinking about, 
I started to think that a SPDIF digital output / input, would give much better 
results:

6 channels, 16 bit, 48KHz = 4.6Mbit/s

I don't know enough about the standard digital format and the maximum bandwidth 
that we could get from a sound card, but in theory we probably could connect the 
digital input on a sound card to digital output on another card (and vice-versa) 
and map the whole thing as a network interface :)

Anyway, this is an extremely crazy, time wasting, "just do it if you have loads 
of time to throw out the window" kind of project, because the cost of ethernet 
NIC's is extremely low these days.

-- 
Paulo Marques - www.grupopie.com

"In a world without walls and fences who needs windows and gates?"

