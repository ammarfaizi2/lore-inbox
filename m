Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292991AbSCJBAA>; Sat, 9 Mar 2002 20:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292996AbSCJA7u>; Sat, 9 Mar 2002 19:59:50 -0500
Received: from mtao2.east.cox.net ([68.1.17.243]:42377 "EHLO
	lakemtao02.cox.net") by vger.kernel.org with ESMTP
	id <S292991AbSCJA7l>; Sat, 9 Mar 2002 19:59:41 -0500
Reply-To: <charles-heselton@cox.net>
From: "Charles Heselton" <charles-heselton@cox.net>
To: =?iso-8859-15?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        "Dan Mann" <mainlylinux@attbi.com>
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel 2.5.6 Interactive performance
Date: Sat, 9 Mar 2002 17:00:15 -0800
Message-ID: <NFBBKFIFGLNJKLMMGGFPOEPCCFAA.charles-heselton@cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <200203092055.57348.Dieter.Nuetzel@hamburg.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How would you implement these thing?  I'm not on the same technical level
that you guys are, and when/if things are out of context, I don't follow.
Can you help?

Charles Heselton
Network Installer
Staffing Alternatives, Inc.
619.261.6866
charles_heselton@hotmail.com <mailto:charles_heselton@hotmail.com>




-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Dieter Nützel
Sent: Saturday, March 09, 2002 1156
To: Dan Mann
Cc: Linux Kernel List
Subject: Re: Kernel 2.5.6 Interactive performance


On Saturday, 9. März 2002 18:55:00, Dan Mann wrote:
[-]
>Machine now feels more responsive than windows 2000 pro machine at work.
>
> Great work guys.

It's due to preemption and Ingo's great O(1)-scheduler.
BIO should help, too but throughput isn't were it should be...;-)

You can get this when you apply preemption+lock-break, O(1) and Andrew
Morten's low-latency to 2.4.18, too.

-aa (vm_29) deliver additional throughput.
If you are running under KDE you should try 3.0 beta2 or -rc2 (!!!)
It flies then.

Regards,
	Dieter
--
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

