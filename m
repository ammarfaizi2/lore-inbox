Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUAaWNM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 17:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUAaWNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 17:13:12 -0500
Received: from hb6.lcom.net ([216.51.236.182]:23424 "EHLO
	petrus.dynamic.digitasaru.net") by vger.kernel.org with ESMTP
	id S265139AbUAaWNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 17:13:09 -0500
Date: Sat, 31 Jan 2004 17:11:37 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Software Suspend 2.0
Message-ID: <20040131231134.GA6084@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
	linux-kernel@vger.kernel.org
References: <20040131071619.GD7245@digitasaru.net> <1075534088.18161.61.camel@laptop-linux> <20040131073848.GE7245@digitasaru.net> <1075537924.17730.88.camel@laptop-linux> <401B6F7A.5030103@gmx.de> <1075540107.17727.90.camel@laptop-linux> <401B7312.3060207@gmx.de> <1075542685.25454.124.camel@laptop-linux> <401B86EB.50604@gmx.de> <yw1xznc4tfle.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xznc4tfle.fsf@kth.se>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Måns Rullgård on Saturday, 31 January, 2004:
>"Prakash K. Cheemplavam" <PrakashKC@gmx.de> writes:
>>> My error. My patch script has put kernel/power/swsusp2.c in the version
>> No problem. I already tested it. After throwing out usb modules, it
>> did suspend, though taking quite long at the kernel and processing
>> (something like that) message. But upon restart, it didn't resume,
>> ie. it didn't find its image, just normal swap space.
>Try disabling write cache on the disk with hdparm -W0 /dev/hde.

When should this be done?

I have 2.6.1 + the 2.6.1-specific patches + core patches.  It suspends
  without difficulty, but on boot, it says it couldn't read a part
  of the resume data (a "chunk", iirc).  The status bar doesn't make
  much progress.

I tried hdparm -W 0 right before the call to hibernate (in a script).
  But I still have the problem.

When should hdparm be called?

Thanks!

-Joseph
