Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319531AbSH3H7k>; Fri, 30 Aug 2002 03:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319498AbSH3H7k>; Fri, 30 Aug 2002 03:59:40 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:22029 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S319531AbSH3H7k>; Fri, 30 Aug 2002 03:59:40 -0400
Message-ID: <3D6F2704.A78F0A0@aitel.hist.no>
Date: Fri, 30 Aug 2002 10:04:20 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.32 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: "Pering, Trevor" <trevor.pering@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
References: <C81D8E612E5DD6119653009027AE9D3EE091D0@FMSMSX36>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pering, Trevor" wrote:

> 2) To use MHz or something else? The problem is that the number here is
> virtually meaningless. It does not translate from machine to machine,
> processor to processor, or application to application. So, if you have to
> pick a meaningless metric, what do you use? I would actually argue for % of
> full capacity instead of MHz, but it doesn't really matter in the end.

Percentages don't buy you much because they are as meaningless as
MHz numbers, or even more so.  Percentages don't translate from
machine to machine either.  One machine might find 50% speed
useful for power saving, another might want 33%.  A third
one might work fine with 75% to prevent overheating.

An MHz carries more meaning - it is a measurable frequency.
Manufacturers tend to specify numbers in MHz.
Percentage of "full" is more problematic because "full"
isn't that well-defined.  

Consider things like overclocking.  That isn't merely a
hack - AMD specifies different max speeds for different
temperatures.  I.e. they officially support higher
clock speed when using liquid cooling.  The speed rating
stored in the cpu is only for the fan-cooling case.

Helge Hafting
