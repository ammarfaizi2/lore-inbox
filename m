Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265785AbSKAV7B>; Fri, 1 Nov 2002 16:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265787AbSKAV7B>; Fri, 1 Nov 2002 16:59:01 -0500
Received: from mario.gams.at ([194.42.96.10]:20040 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S265785AbSKAV7A> convert rfc822-to-8bit;
	Fri, 1 Nov 2002 16:59:00 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.3
From: Bernd Petrovitsch <bernd@gams.at>
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: Matt Porter <porter@cox.net>, Mark Mielke <mark@mark.mielke.cc>,
       Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY 
References: <20021101071700.A19847@jaquet.dk> 
In-reply-to: Your message of "Fri, 01 Nov 2002 07:17:00 +0100."
             <20021101071700.A19847@jaquet.dk> 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Fri, 01 Nov 2002 23:05:13 +0100
Message-ID: <27827.1036188313@frodo.gams.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Andersen <rasmus@jaquet.dk> wrote:
>On Fri, Nov 01, 2002 at 12:30:14AM +0100, Bernd Petrovitsch wrote:
[...]
>> Hmm, which of the 2.5.44 patches (from
>> http://www.jaquet.dk/kernel/config_tiny/) are to be applied?
>> Applying all seem to work but some config options are duplicated.
>
>Could you provide a little more detail? This is not by design :)
>Keep in mind that the 'allinone' patch encompasses all of the
>others. And that only 2.5.44-* are of interest.

I see on http://www.jaquet.dk/kernel/config_tiny/ the following list 
of 2.5.44 patches:
----  snip  ----
2.5.44-allinone         30-Oct-2002 23:15    23k
2.5.44-config           30-Oct-2002 23:15     1k
2.5.44-initstr          30-Oct-2002 23:11   183k
2.5.44-nohashes         30-Oct-2002 23:11     3k
2.5.44-noinlines        30-Oct-2002 23:19    14k
2.5.44-noscript         30-Oct-2002 23:11     1k
2.5.44-noswap           30-Oct-2002 23:10     6k
----  snip  ----
Just looking at the patch sizes, I thought all are independent 
(though "allinone" indicates something different). So I applied all 
to one tree (which gave the above mentioned result).
Now playing around with the patches shows that 2.5.44-allinone
apparently contains all others _except_ 2.5.44-initstr which is 
completely independent.
Sorry for the confusion.

	Bernd
-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


