Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263758AbRFCUwI>; Sun, 3 Jun 2001 16:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263694AbRFCUaU>; Sun, 3 Jun 2001 16:30:20 -0400
Received: from front2.grolier.fr ([194.158.96.52]:25541 "EHLO
	front2.grolier.fr") by vger.kernel.org with ESMTP
	id <S263686AbRFCUaO> convert rfc822-to-8bit; Sun, 3 Jun 2001 16:30:14 -0400
Date: Sun, 3 Jun 2001 19:18:24 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: Tim Hockin <thockin@sun.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: Re: [PATCH] sym53c8xx timer and smp fixes
In-Reply-To: <3B16EF26.2F44BE3F@sun.com>
Message-ID: <Pine.LNX.4.10.10106031908440.1774-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 May 2001, Tim Hockin wrote:

> All,
> 
> Attached is a patch for sym53c8xx.c to handle the error timer better, and
> be more proper for SMP.  The changes are very simple, and have been beaten
> on by us.  Please let me know if there are any problems accepting this
> patch for general inclusion.

I have no problems accepting your patch. Thanks for it.

I just want to have to deal with a human manageable finite number of
actual driver versions :). I also want the same driver source to also be
useable on recent 2.2 kernels.

About timers in modules and more generally either timers in drivers or
modules unloading, you must keep in mind that this stuff has been racy for
years in Linux. Allow time for me to check if it is really fixed in latest
kernel and so to make sure it is worthwhile to apply your patch.

  Gérard.

