Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132338AbRD1TBk>; Sat, 28 Apr 2001 15:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132614AbRD1TBb>; Sat, 28 Apr 2001 15:01:31 -0400
Received: from email.cwcom.net ([195.44.0.152]:37904 "EHLO cwcom.net")
	by vger.kernel.org with ESMTP id <S132338AbRD1TBN>;
	Sat, 28 Apr 2001 15:01:13 -0400
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
X-Comment-To: Jens Axboe
In-Reply-To: <Pine.LNX.4.21.0104281935560.687-100000@rfhome.fietze.de> <Pine.LNX.4.21.0104281935560.687-100000@rfhome.fietze.de> <20010428195742.C11698@suse.de>
Subject: Re: Kernel 2.4.[234] kernel panic, DMA Pool, CDROM Mount Failure
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: daria.co.uk
Message-ID: <1e14.3aeb0dc8.44a42@trespassersw.daria.co.uk>
Date: Sat, 28 Apr 2001 18:36:56 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010428195742.C11698@suse.de>,
	Jens Axboe <axboe@suse.de> writes:
JA> On Sat, Apr 28 2001, Roman Fietze wrote:
>> Hello,
>> 
>> I reported this before and the bug still exists in 2.4.4. The problem can
>> be circumvented by using drivers/scsi/sr.c from kernel 2.4.[01]. This
>> "fix" did not help just me, but somebody else I had contact with on the
>> net.
JA> 
JA> Is the CDROM on the 1542?
JA> 
JA> And could you include full panic info, please?
JA> 

In my case, with AHA 1542 (as reported here earlier), I get:

Apr 26 22:36:13 kanga kernel: sr: ran out of mem for scatter pad 
Apr 26 22:36:13 kanga kernel: Kernel panic: scsi_free:Bad offset 

Hope this is of some help.

