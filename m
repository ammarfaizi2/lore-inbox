Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292898AbSCIT4Y>; Sat, 9 Mar 2002 14:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292900AbSCIT4O>; Sat, 9 Mar 2002 14:56:14 -0500
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:6907 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S292898AbSCIT4A>; Sat, 9 Mar 2002 14:56:00 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Dan Mann <mainlylinux@attbi.com>
Subject: Re: Kernel 2.5.6 Interactive performance
Date: Sat, 9 Mar 2002 20:55:57 +0100
X-Mailer: KMail [version 1.3.9]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200203092055.57348.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

