Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292674AbSCJBMY>; Sat, 9 Mar 2002 20:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292694AbSCJBMP>; Sat, 9 Mar 2002 20:12:15 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:24970 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S292674AbSCJBL6>; Sat, 9 Mar 2002 20:11:58 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: <charles-heselton@cox.net>, "Dan Mann" <mainlylinux@attbi.com>
Subject: Re: Kernel 2.5.6 Interactive performance
Date: Sun, 10 Mar 2002 02:11:49 +0100
X-Mailer: KMail [version 1.3.9]
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>,
        "J.A. Magallon" <jamagallon@able.es>
In-Reply-To: <NFBBKFIFGLNJKLMMGGFPOEPCCFAA.charles-heselton@cox.net>
In-Reply-To: <NFBBKFIFGLNJKLMMGGFPOEPCCFAA.charles-heselton@cox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200203100211.49572.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sonntag, 10. März 2002 02:00:02, Charles Heselton wrote:
> How would you implement these thing?  I'm not on the same technical level
> that you guys are, and when/if things are out of context, I don't follow.
> Can you help?

If you are somewhat open for "new" (experimental) stuff I can prepare a patch 
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
