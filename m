Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268292AbTAMTMF>; Mon, 13 Jan 2003 14:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268293AbTAMTME>; Mon, 13 Jan 2003 14:12:04 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:46558 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S268292AbTAMTMD>; Mon, 13 Jan 2003 14:12:03 -0500
Date: Tue, 14 Jan 2003 08:17:47 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <99790000.1042485467@localhost.localdomain>
In-Reply-To: <1042482811.19497.10.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0301130834500.1903-100000@home.transmeta.com>
 <1042482811.19497.10.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe I may have seen it on 2.5.53 just surfing on an Alcatel 
Speedtouch DSL modem (using PPPoATM) while compiling in a background 
gnome-terminal (and probably running a few other things, maybe including 
top, in terminals).  I'll try to confirm that.

Andrew

--On Monday, January 13, 2003 18:33:31 +0000 Alan Cox 
<alan@lxorguk.ukuu.org.uk> wrote:

> On Mon, 2003-01-13 at 16:35, Linus Torvalds wrote:
>> On Sun, 12 Jan 2003, Greg KH wrote:
>> >
>> > Anyway, here's a patch with your new lock, if you want to apply it.
>>
>> I'd like to have some verification (or some test-suite) to see whether
>> it  makes any difference at all before applying it.
>>
>> Alan, what's your load?
>
> Lots of serial activity (standard PC serial ports) with carrier drops
> present and random oopses appear. I've seen ppp oopses too but don't know
> if they are related. I tried duplicating it with pty/tty traffic on a dual
> PPro200 and suprisingly that did the same.
>
> Ages ago I chased serial bugs down by doing data transfers between two
> PC's while one of them was strobing the carrier up and down on the test
> PC with varying frequencies
>
> I've not had time to try that paticular abuse again alas.
>
> Alan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


