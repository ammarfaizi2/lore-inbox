Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261670AbSJIKhZ>; Wed, 9 Oct 2002 06:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261671AbSJIKhZ>; Wed, 9 Oct 2002 06:37:25 -0400
Received: from tom.rz.uni-passau.de ([132.231.51.4]:28628 "EHLO
	tom.rz.uni-passau.de") by vger.kernel.org with ESMTP
	id <S261670AbSJIKhV>; Wed, 9 Oct 2002 06:37:21 -0400
Message-Id: <200210091042.g99Agwjm009964@tom.rz.uni-passau.de>
Date: Wed, 9 Oct 2002 12:37:22 +0100
From: "lell02" <lell02@stud.uni-passau.de>
To: Jens Axboe <axboe@suse.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Status of UDF CD packet writing?
X-mailer: Foxmail 4.1 [eg]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Oct 08 2002, lell02 wrote:
>> hi, 
>> 
>> >Will Jens Axboes patch for CD packet writing for CD-R/RW make it in
>> >before the feature freeze? I know Jens Axboe is busy with more basic I/O
>> >stuff, but i sincerely hope it can be squeezed in before 2.6/3.0 is
>> >released.
>> 
>> jens stated on this about 1-2 days ago. he said, it would be little
>> modification on the ide-cdrom, to make it work with cd-mrw/ packet
>> writing.  so it could go in after the feature freeze.
>
>You might be talking about two different patches -- one for cd-rw
>support (this is the pktcdvd (or -packet) patch that Peter Osterlund has
>been maintaining) and the other for cd-mrw. The cd-mrw patch is very
>small, not a lot is required to support that in the cd driver.
>Supporting cd-rw is a lot harder, basically you have to do in software
>what cd-mrw does in hardware (defect management, read-modify-write
>packet gathering, etc).
>
>cd-mrw will definitely be in 2.6. cd-rw support maybe, I haven't even
>looked at that lately.
>

thanx for clearing out these differences. 

but, isn't cd-mrw supposed to replace the old packet-writing technique?
so, in the end, there wouldn't be any need for packet-writing, if every burner 
ships with cd-mrw-support... i read in the "specs", that the technology would 
be much better.



Marcus Lell



