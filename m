Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318008AbSIJSnw>; Tue, 10 Sep 2002 14:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318009AbSIJSnw>; Tue, 10 Sep 2002 14:43:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48655 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318008AbSIJSnu>;
	Tue, 10 Sep 2002 14:43:50 -0400
Message-ID: <3D7E3E62.5070105@mandrakesoft.com>
Date: Tue, 10 Sep 2002 14:48:02 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "David S. Miller" <davem@redhat.com>, david-b@pacbell.net,
       mdharm-kernel@one-eyed-alien.net, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
References: <Pine.LNX.4.44.0209101132320.3280-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Tue, 10 Sep 2002, David S. Miller wrote:
> 
>>   
>>   IMO we should have ASSERT() and OHSHIT(),
>>
>>I fully support the addition of an OHSHIT() macro.
> 
> 
> Oh, please no. We'd end up with endless asserts in the networking layer, 
> just because David would find it amusing. 

hehe :)


> I think the approach should clearly spell what the trouble level is:
> 
> 	DEBUG(x != y, "x=%d, y=%d\n", x, y);
> 
> 	WARN(x != y, "crap happens: x=%d y=%d\n", x, y);
> 
> 	FATAL(x != y, "Aiee: x=%d y=%d\n", x, y);


I like, that would allow me to kill per-file debug code in some of my 
net drivers...

	Jeff


