Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129623AbRBNRmz>; Wed, 14 Feb 2001 12:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129620AbRBNRmp>; Wed, 14 Feb 2001 12:42:45 -0500
Received: from smtp8.xs4all.nl ([194.109.127.134]:41698 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S130127AbRBNRmb>;
	Wed, 14 Feb 2001 12:42:31 -0500
Date: Wed, 14 Feb 2001 17:41:40 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ingo Molnar <mingo@chiara.elte.hu>, Andrew Morton <andrewm@uow.edu.au>,
        Manfred Spraul <manfred@colorfullife.com>,
        Frank de Lange <frank@unternet.org>,
        Martin Josefsson <gandalf@wlug.westbo.se>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.1, 2.4.2-pre3: APIC lockups
Message-ID: <20010214174140.B824@grobbebol.xs4all.nl>
In-Reply-To: <Pine.GSO.3.96.1010213203553.1931A-100000@delta.ds2.pg.gda.pl> <20010214173057.A824@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010214173057.A824@grobbebol.xs4all.nl>; from roel@grobbebol.xs4all.nl on Wed, Feb 14, 2001 at 05:30:57PM +0000
X-OS: Linux grobbebol 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2001 at 05:30:57PM +0000, Roeland Th. Jansen wrote:
> other observations -- approx 6000 ints from the ne2k card/sec.
> MIS shows approx 1% that goes wrong with a ping flood.

oops. had to count both CPU0 and CPU1's interrupts. after 23 minutes :

           CPU0       CPU1
 19:    3824114    3823371   IO-APIC-level  eth0
MIS:      29025

makes approx 0.3%..

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
