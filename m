Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292694AbSCJBPO>; Sat, 9 Mar 2002 20:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292700AbSCJBPF>; Sat, 9 Mar 2002 20:15:05 -0500
Received: from mtao1.east.cox.net ([68.1.17.244]:37349 "EHLO
	lakemtao01.cox.net") by vger.kernel.org with ESMTP
	id <S292694AbSCJBO6>; Sat, 9 Mar 2002 20:14:58 -0500
Reply-To: <charles-heselton@cox.net>
From: "Charles Heselton" <charles-heselton@cox.net>
To: =?iso-8859-15?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        "Dan Mann" <mainlylinux@attbi.com>
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>,
        "J.A. Magallon" <jamagallon@able.es>
Subject: RE: Kernel 2.5.6 Interactive performance
Date: Sat, 9 Mar 2002 17:15:32 -0800
Message-ID: <NFBBKFIFGLNJKLMMGGFPKEPDCFAA.charles-heselton@cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <200203100211.49572.Dieter.Nuetzel@hamburg.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That would be great.  I'm currently running 2.4.18.  I'm always up for
things that would help improve performance, even if they are "experimental".

Thanks,
Charles Heselton
Network Installer
Staffing Alternatives, Inc.
619.261.6866
charles_heselton@hotmail.com <mailto:charles_heselton@hotmail.com>




-----Original Message-----
From: Dieter Nützel [mailto:Dieter.Nuetzel@hamburg.de]
Sent: Saturday, March 09, 2002 1712
To: charles-heselton@cox.net; Dan Mann
Cc: Linux Kernel List; J.A. Magallon
Subject: Re: Kernel 2.5.6 Interactive performance


On Sonntag, 10. März 2002 02:00:02, Charles Heselton wrote:
> How would you implement these thing?  I'm not on the same technical level
> that you guys are, and when/if things are out of context, I don't follow.
> Can you help?

If you are somewhat open for "new" (experimental) stuff I can prepare a
patch
on top of 2.4.18 or 2.4.19-pre2 for you.

But Andrea Arcangeli informed me that vm-29 had a deadlock bug in the recent
fixes for the bh headers. vm-28 is fine or soon to be available vm-30.

It didn't hit me for the last two days.

Regards,
	Dieter

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Dieter Nützel
> Sent: Saturday, March 09, 2002 1156
> To: Dan Mann
> Cc: Linux Kernel List
> Subject: Re: Kernel 2.5.6 Interactive performance
>
>
> On Saturday, 9. März 2002 18:55:00, Dan Mann wrote:
> [-]
>
> >Machine now feels more responsive than windows 2000 pro machine at work.
> >
> > Great work guys.
>
> It's due to preemption and Ingo's great O(1)-scheduler.
> BIO should help, too but throughput isn't were it should be...;-)
>
> You can get this when you apply preemption+lock-break, O(1) and Andrew
> Morten's low-latency to 2.4.18, too.
>
> -aa (vm_29) deliver additional throughput.
> If you are running under KDE you should try 3.0 beta2 or -rc2 (!!!)
> It flies then.
>
> Regards,
> 	Dieter

