Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVALCYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVALCYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 21:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVALCYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 21:24:48 -0500
Received: from [209.195.52.120] ([209.195.52.120]:62449 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261193AbVALCYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 21:24:46 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Tue, 11 Jan 2005 18:23:39 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [PATCH] make uselib configurable (was Re: uselib()  & 2.6.X?)
In-Reply-To: <20050112021246.GE4325@ip68-4-98-123.oc.oc.cox.net>
Message-ID: <Pine.LNX.4.60.0501111820350.18921@dlang.diginsite.com>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl>
 <20050107170712.GK29176@logos.cnet> <1105136446.7628.11.camel@localhost.localdomain>
 <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org> <20050107221255.GA8749@logos.cnet>
 <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org>
 <20050111225127.GD4378@ip68-4-98-123.oc.oc.cox.net> <20050111235907.GG2760@pclin040.win.tue.nl>
 <20050112021246.GE4325@ip68-4-98-123.oc.oc.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2005, Barry K. Nathan wrote:

>> People always claim that Linux is good in preserving binary compatibility.
>> Don't know how true that was, but introducing such config options doesnt
>> help.
>
> Binary compatibility is good to have, but it isn't everything in life.
> *Optionally* breaking compatibility with certain types of old binaries
> doesn't seem so bad to me. People who want binary compatibility can have
> it, and people who don't need it can choose to not install the old code
> on their systems.

we already allow people to not support a.out formats, this breaks binary 
compatability (probably much more severely then this does)

however we do need to be very sure that if any call is dropped as being 
obsolete it really is not likly to be used (see all the recent flames 
about people dropping (or proposing dropping) features out of the kernel 
for examples of what not to mark obsolete)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
