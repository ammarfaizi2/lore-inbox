Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312413AbSDJIY0>; Wed, 10 Apr 2002 04:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312529AbSDJIYZ>; Wed, 10 Apr 2002 04:24:25 -0400
Received: from vivi.uptime.at ([62.116.87.11]:2023 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S312413AbSDJIYY>;
	Wed, 10 Apr 2002 04:24:24 -0400
Reply-To: <o.pitzeier@uptime.at>
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: <axp-kernel-list@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <aleks@uptime.at>
Subject: RE: Kernel 2.4.9 and ABOVE
Date: Wed, 10 Apr 2002 10:23:36 +0200
Organization: =?us-ascii?Q?UPtime_Systemlosungen?=
Message-ID: <000401c1e069$0638faf0$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <20020409144631.J2807@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK I got it... My Alpha works now.

I must have been an idiot. :o)

One of the harddrives seems to have errors. After reinstalling
RedHat on the other drive. tune2fs -j -c0 -i0 /dev/sda[1,3,4,5]
Editing fstab, rebooting.

Crashing the system via the halt button. Restarting -> System
recovers the journal and then YIPIEEE(!) no more errors.
Everything works!

Thanks to everyone who helped me with this f***in' problem.
Especially to Stephen Tweedie, Jochen Buehler and
Peter Leif Rasmussen...

-Oliver

PS: I'm now running kernel 2.4.18-grsec-1.9.4 :o)

PPS: I guess it's now up to RedHat to build a nice Kernel-RPMs
and release (together with Compaq) RedHat 7.2 Alpha Edition. :o)

> -----Original Message-----
> From: axp-kernel-list-admin@redhat.com 
> [mailto:axp-kernel-list-admin@redhat.com] On Behalf Of 
> Stephen C. Tweedie
> Sent: Tuesday, April 09, 2002 3:47 PM
> To: axp-kernel-list@redhat.com
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Kernel 2.4.9 and ABOVE
> 
> 
> Hi,
> 
> On Tue, Apr 09, 2002 at 02:56:17PM +0200, Oliver Pitzeier wrote:
> 
> > rm: cannot remove directory EXT3-fs error (device sd(8,18)):
> > ext3_free_blocks: bit already cleared for block 1607322 
> > `linux/include/cEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit 
> > already cleared for block 1607323
> 
> Is this captured console output or actual syslog contents?  
> Depending on the log level, it's quite possible that there 
> are kernel messages which are going to one source or the 
> other but not both.
> 
> --Stephen
> 
> 
> 
> _______________________________________________
> Axp-kernel-list mailing list
> Axp-kernel-list@redhat.com 
> https://listman.redhat.com/mailman/listinfo/ax> p-kernel-list
> 


