Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262007AbSJIVYP>; Wed, 9 Oct 2002 17:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262034AbSJIVYP>; Wed, 9 Oct 2002 17:24:15 -0400
Received: from tom.rz.uni-passau.de ([132.231.51.4]:9963 "EHLO
	tom.rz.uni-passau.de") by vger.kernel.org with ESMTP
	id <S262007AbSJIVYN>; Wed, 9 Oct 2002 17:24:13 -0400
Message-Id: <200210092129.g99LTqjm018026@tom.rz.uni-passau.de>
Date: Wed, 9 Oct 2002 23:24:15 +0100
From: "lell02" <lell02@stud.uni-passau.de>
To: Brian Gerst <bgerst@didntduck.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Status of UDF CD packet writing?
X-mailer: Foxmail 4.1 [eg]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, 
>lell02 wrote:
>>>On Tue, Oct 08 2002, lell02 wrote:
>>>
>>>>hi, 
>>>>
>>>>
>>>>>Will Jens Axboes patch for CD packet writing for CD-R/RW make it in
>>>>>before the feature freeze? I know Jens Axboe is busy with more basic I/O
>>>>>stuff, but i sincerely hope it can be squeezed in before 2.6/3.0 is
>>>>>released.
>>>>
>>>>jens stated on this about 1-2 days ago. he said, it would be little
>>>>modification on the ide-cdrom, to make it work with cd-mrw/ packet
>>>>writing.  so it could go in after the feature freeze.
>>>
>>>You might be talking about two different patches -- one for cd-rw
>>>support (this is the pktcdvd (or -packet) patch that Peter Osterlund has
>>>been maintaining) and the other for cd-mrw. The cd-mrw patch is very
>>>small, not a lot is required to support that in the cd driver.
>>>Supporting cd-rw is a lot harder, basically you have to do in software
>>>what cd-mrw does in hardware (defect management, read-modify-write
>>>packet gathering, etc).
>>>
>>>cd-mrw will definitely be in 2.6. cd-rw support maybe, I haven't even
>>>looked at that lately.
>>>
>> 
>> 
>> thanx for clearing out these differences. 
>> 
>> but, isn't cd-mrw supposed to replace the old packet-writing technique?
>> so, in the end, there wouldn't be any need for packet-writing, if every burner 
>> ships with cd-mrw-support... i read in the "specs", that the technology would 
>> be much better.
>
>For drives that support cd-mrw.  Older cd-rw drives will still need the 
>full blown packet writing patch though.

so, both have to go in 2.6/3.0. i hope, they do. it is clear, relying to jens, cd-mrw
is going to be in the future "stable"  kernel, so the question it on pkt-writing...
this code is more than 2 years old (i suppose). so it would be a gain, to include 
it within the official kernel. that would also be a point to the desktop-linux users
to use linux. (that ones dosen't use linux, until it supports things naturely (aka 
in mainline), 'cause they don't believe, it would be stable, until it is in mainline)


Marcus Lell


