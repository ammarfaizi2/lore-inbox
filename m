Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275487AbTHNUMr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275489AbTHNUMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:12:47 -0400
Received: from zeke.inet.com ([199.171.211.198]:63896 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S275487AbTHNUMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:12:38 -0400
Message-ID: <3F3BED30.90904@inet.com>
Date: Thu, 14 Aug 2003 15:12:32 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030708
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make modules work in Linus' tree on ARM
References: <Pine.LNX.4.44.0308140917350.8148-100000@home.osdl.org> <1060879622.5983.7.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2003-08-14 at 17:19, Linus Torvalds wrote:
> 
>>Does anybody actually _use_ /proc/kcore? It was one of those "cool 
>>feature" things, but I certainly haven't ever used it myself except for 
>>testing, and it's historically often been broken after various kernel 
>>infrastructure updates, and people haven't complained..
>>
>>Comments?
> 
> 
> Now if you'd agree to merge the kgdb stubs to replace it.... ;)

I for one would like to see that.  However:
The simple protocol that it uses needs to be factored out to an 
arch-independent place, and the various archs need to be modified to use 
it.  To get to that point will likely require someone doing it for one 
or two archs and then having enough community clout to convince other 
archs to merge with it.  It could get to the point where it's a pretty 
clean implementation (for debugger hooks ;) ).

No, that isn't something I can take on. :/  (Though I did get it 
partially working on 2.5 XScale.)

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

