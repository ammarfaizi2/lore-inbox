Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314702AbSD2TMp>; Mon, 29 Apr 2002 15:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314735AbSD2TMo>; Mon, 29 Apr 2002 15:12:44 -0400
Received: from otter.mbay.net ([206.55.237.2]:13322 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S314702AbSD2TMn> convert rfc822-to-8bit;
	Mon, 29 Apr 2002 15:12:43 -0400
From: John Alvord <jalvo@mbay.net>
To: tomas szepe <kala@pinerecords.com>
Cc: Ian Molton <spyro@armlinux.org>, alchemy@us.ibm.com, rml@tech9.net,
        alan@lxorguk.ukuu.org.uk, rthrapp@sbcglobal.net,
        linux-kernel@vger.kernel.org
Subject: Re: The tainted message
Date: Mon, 29 Apr 2002 12:11:48 -0700
Message-ID: <ui6rcugr35a6h8u1tf6sq5js4mn5c19sq2@4ax.com>
In-Reply-To: <E171TzX-0008PF-00@the-village.bc.nu> <1019926629.2045.698.camel@phantasy> <1020099580.5131.14.camel@w-beattie1> <20020429171516.GA25377@louise.pinerecords.com> <20020429184331.3230f5ab.spyro@armlinux.org> <20020429174232.GA25502@louise.pinerecords.com>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2002 19:42:32 +0200, tomas szepe <kala@pinerecords.com>
wrote:

>> tomas szepe Awoke this dragon, who will now respond:
>> 
>> >  > Warning: The module (%s) does not seem to have a compatible license.
>> >  >          Please contact the supplier of this module regarding any
>> >  >          problems, or reproduce the problem after rebooting without
>> >  >          ever loading this module.
>> >  > 
>> >  > shorter?
>> > 
>> >  I don't think you can strip the part about open-ness of the code --
>> >  it's an essential part of the explanation. And "any problems" might
>> >  be too broad.
>> 
>> Moreover, I think the 'compatible license thing doesnt fly.
>> 
>> the argument against CLOSE modules is that they make the _whole_package_
>> undebuggable.
>> 
>> if the source is available, no matter HOW crippling its license, the
>> package _IS_ debuggable.
>> 
>> thie warning should be:
>> 
>> Warning: Module %s is not open source, and as such, loading it will make
>> your kernel un-debuggable. Please do not submit bug reports from a kernel
>> with this module loaded, as they will be useless, and likely ignored.
>
>Very good! I'd only change the tense to "The non-opensource module %s is
>about to be loaded, which will make your kernel impossible to debug," so
>that it's crystal clear that the message is not a failure notification.

Pschologically it would be better to phrase it as a postive statement.

Warning: Module %s is not open source, and as such, loading it will
make your kernel un-debuggable. Before reporting problems to
Linux-kernel, please replicate the problem without the module loaded. 

john alvord
