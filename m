Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269790AbRHDEfQ>; Sat, 4 Aug 2001 00:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269791AbRHDEfG>; Sat, 4 Aug 2001 00:35:06 -0400
Received: from 35.roland.net ([65.112.177.35]:51470 "EHLO earth.roland.net")
	by vger.kernel.org with ESMTP id <S269790AbRHDEe4>;
	Sat, 4 Aug 2001 00:34:56 -0400
Message-ID: <3B6B7B1D.3050602@roland.net>
Date: Fri, 03 Aug 2001 23:33:33 -0500
From: Jim Roland <jroland@roland.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; rv:0.9.1) Gecko/20010622
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark Atwood <mra@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <m33d78de7d.fsf@flash.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's pretty simple.  If you have no special options to pass to the module:

alias eth0 modulename
(example for 3C905B-TX:  alias eth0 3c90x)


Mark Atwood wrote:

>I'm trying to figure out how "alias ethX" works in /etc/modules.conf
>
>Is it some "magic" in depmod / modprobe? And how is the network
>interface identifier then passed into the module when it loads?
>
>A nice whitepaper or doc or a few pointers or handholding would be
>apprecated.
>


