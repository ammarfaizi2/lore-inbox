Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277823AbRJZHFx>; Fri, 26 Oct 2001 03:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277866AbRJZHFo>; Fri, 26 Oct 2001 03:05:44 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:9093 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S277823AbRJZHFb>; Fri, 26 Oct 2001 03:05:31 -0400
Message-ID: <XFMail.20011026090540.R.Oehler@GDImbH.com>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3BD84A80.BB08EBD8@zip.com.au>
Date: Fri, 26 Oct 2001 09:05:40 +0200 (MEST)
Reply-To: R.Oehler@GDImbH.com
From: R.Oehler@GDImbH.com
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: Linux 2.4.10: printk() deadlocks
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25-Oct-2001 Andrew Morton wrote:
> Sorry, but I think you must be doing something strange to make this
> happen - can you please diagnose a little further?  Investigate
> further with kdb?  Can you send me the wherewithals to reproduce
> it?  Are you running SMP?
No, just out of sleep.


Sorry, folks

printk() does not deadlock.
I just put a funny little typo at the wrong place in my code
which resulted in a very fast eternal loop. So the system
froze and lloked like deadlocked. The CPU was nearly always in 
printk().

Thanks andrew for opening my eyes and sorry again for the 
inconveniance.

        Ralf

 -----------------------------------------------------------------
|  Ralf Oehler
|  GDI - Gesellschaft fuer Digitale Informationstechnik mbH
|
|  E-Mail:      R.Oehler@GDImbH.com
|  Tel.:        +49 6182-9271-23 
|  Fax.:        +49 6182-25035           
|  Mail:        GDI, Bensbruchstraﬂe 11, D-63533 Mainhausen
|  HTTP:        www.GDImbH.com
 -----------------------------------------------------------------

time is a funny concept

