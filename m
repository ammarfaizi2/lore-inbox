Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267236AbTBDKvL>; Tue, 4 Feb 2003 05:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267238AbTBDKvL>; Tue, 4 Feb 2003 05:51:11 -0500
Received: from dux1.tcd.ie ([134.226.1.23]:47333 "HELO dux1.tcd.ie")
	by vger.kernel.org with SMTP id <S267236AbTBDKvJ>;
	Tue, 4 Feb 2003 05:51:09 -0500
Subject: Re: CPU throttling??
From: Seamus <assembly@gofree.indigo.ie>
To: John Bradford <john@grabjohn.com>
Cc: andrew.grover@intel.com, davej@codemonkey.org.uk, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200302041031.h14AVYcv000642@darkstar.example.net>
References: <200302041031.h14AVYcv000642@darkstar.example.net>
Content-Type: text/plain
Organization: 
Message-Id: <1044356481.17362.49.camel@taherias.sre.tcd.ie>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1- 
Date: 04 Feb 2003 11:01:21 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-04 at 10:31, John Bradford wrote:
> > Hmmm, it seems most of these apply to mobile processors.
> > I'm using AMD 1.4 Athlon Thunderbird on a desktop, as you know my
> > processor was the one before release low power AMD XP processors.
> > It uses a savage amount of power, and operates well into 60 and 70
> > degrees celcius.
> 
> Is that the temperature when it's halted, or when it's in use?  I have
> never observed the Duron 650 machine that's here get above 30 degrees
> C, and the MMX-200 doesn't have a temperature sensor, but I'd estimate
> that it never goes above 40.
> 

OK, this is the full story.
I have an AMD 1.4GHz Athlon Thunderbird on ASUS motherboard.
While computer must be up 24/7 there are times that it may not be in use
(at all) for periods as long as 12 hours. 
I'd like to minimize power consumption at those times.
So far achieving it by monitor powering off and hard-disk suspending.

I don't know how much I can save on CPU, but when it's completely idle
(normal mode, not halted though) its at 59-61 degrees celcius, when its
at 100% use, it easily reaches 74+. Aparently its normal with AMD Athlon
Thunderbird CPUs !

Now, I want to put CPU into *lowest* power consumption mode (whether
that be CPU C state, halt state, lower freq or lower voltage) at times
when I don't need it (but as you know, at all times there are processes
running, no matter how infrequent and low cpu usage they have, so I can
hardly see ideal "Halt" mode possible), so whats the best action ?

Seamus

