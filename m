Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbSK2IQT>; Fri, 29 Nov 2002 03:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266979AbSK2IQT>; Fri, 29 Nov 2002 03:16:19 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:9441 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266977AbSK2IQS>; Fri, 29 Nov 2002 03:16:18 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 29 Nov 2002 00:23:25 -0800
Message-Id: <200211290823.AAA26196@adam.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: Modules with list
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz,
       zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>In message <200211280025.QAA07845@baldur.yggdrasil.com> you write:
>> Rusty Russel wrote:

>That's Russell 8)

>> >Sorry, that's why I said "*If O_NONBLOCK* is specified" (ie. still
>> >drop it for the --wait case).
>> 
>> 	Oops!  Sorry for misreading your message.
>> 
>> 	Even though it was not responsive to what you described, I do
>> hope you see my point about the problem with "rmmod --wait".

>But's it's an absolute requirement, to make modules removable in some
>circumstances, otherwise you end up being starved and the module
>cannot be removed (security modules and netfilter modules strike me as
>the obvious cases, but there are probably more).

	That may be a drawback, but I would necessarily say that
avoiding those drawbacks is an "absolute requirement" based on the
disadvantages you listed, nor would attaching that label magically
eliminate the problem that I described.


Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
