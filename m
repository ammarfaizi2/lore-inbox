Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbUJZTDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbUJZTDT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 15:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUJZTDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 15:03:19 -0400
Received: from zamok.crans.org ([138.231.136.6]:15752 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261400AbUJZTDL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 15:03:11 -0400
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Massimo Cetra <mcetra@navynet.it>, Ed Tomlinson <edt@aei.ca>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Bill Davidsen <davidsen@tmr.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
References: <200410260644.47307.edt@aei.ca>
	<00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin>
	<4d8e3fd3041026050823d012dc@mail.gmail.com>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Tue, 26 Oct 2004 21:03:10 +0200
In-Reply-To: <4d8e3fd3041026050823d012dc@mail.gmail.com> (Paolo Ciarrocchi's
	message of "Tue, 26 Oct 2004 14:08:36 +0200")
Message-ID: <877jpdcnf5.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> disait dernièrement que :
 
>> To my mind, we only need to make clear that a stable kernel is a stable
>> kernel.
>> Not a kernel for experiments.
>
> 2.6 is not an experimental kernel. Not at all.

clearly do I agree.
  
>> To my mind, stock 2.6 kernels are nice for nerds trying patches and
>> willing to recompile their kernel once a day. They are not suitable for
>> servers. Several times on testing machines, switching from a 2.6 to the
>> next one has caused bugs on PCI, acpi, networking and so on.
>
> I don't understand what you mean here. 
> Did you report these problems to lkml ?
> It's the firts time I heard about this kind of problems.

I will just add this:
we, young students from all horizons here at the ENS Cachan, run a huge network
(~900 hosts), with 4 important servers, all running 2.6. And my conclusion, as
I cannot speak for my fellow colleagues but think most would agree, is that
these servers behave *a* *lot* *better* since we switch. We had problems first
but they were mostly due to the switch to Debian testing distribution (from
old Woody).
Also we have a 4-way (bi-Xeon with HT) running 2.6.7, playing proxy squid to
serve our entire network, up since 131 days, with no problems; and the 2.6.x
switch was more a blessing than a pain in the butt, since 2.4.x just let him
play more and more in system time.... Thanks to sched domains and _real_ HT
scheduling support.

And these are production servers, no more no less.
  
>> The direction is lost. How many patchsets for vanilla kernel exist?
>
> It was the same for 2.4. And that's not _BAD_, is _GOOD_.

yup -mm, -ac existed in 2.4 series.
and do not forget that -mm series are a stage for patches aiming mainline,
not a special patchset among others.

>> Someone has decided that linux must go on desktops as well and
>> developing new magnificent features for desktop users is causing serious
>> problems to the ones who use linux at work on production servers.
>
> Who ?

Users decided, I guess :)
  
>> 2.4 tree is still the best solution for production.

I do not think so, I think it depends on the hardware you bear.

>> 2.6 tree is great for gentoo users who like gcc consuming all CPU
>> (maxumum respect to gentoo but I prefer debian)

huh ? what's the point ????
Our 2.6 servers run Debian testing with a little trouble.

Best regards, and hurray for Linux 2.6 series !!

Mathieu

-- 
"One of the great things about books is sometimes there are some fantastic
pictures."

George W. Bush
January 3, 2000
Quoted in U.S. News & World Report.

