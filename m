Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131672AbRDJMxM>; Tue, 10 Apr 2001 08:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131691AbRDJMxC>; Tue, 10 Apr 2001 08:53:02 -0400
Received: from iris.mc.com ([192.233.16.119]:8658 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S131672AbRDJMwp>;
	Tue, 10 Apr 2001 08:52:45 -0400
From: Mark Salisbury <mbs@mc.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: No 100 HZ timer !
Date: Tue, 10 Apr 2001 08:42:33 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200104091830.NAA03017@ccure.karaya.com> <01041008110318.01893@pc-eng24.mc.com> <20010410144554.A16207@gruyere.muc.suse.de>
In-Reply-To: <20010410144554.A16207@gruyere.muc.suse.de>
MIME-Version: 1.0
Message-Id: <0104100846101E.01893@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2001, Andi Kleen wrote:
> .... Also generally the kernel has quite a lot of timers. 

are these generaly of the long interval, failure timeout type?
i.e. 5 second device timeouts that are killed before they get executed because
the device didn't timeout?  if so, they have no effect on the number of timer
interrupts because they generally never get hit.  and when they do, you have to
pay the price anyway.

 -- 
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------**
**  I will be riding in the Multiple Sclerosis    **
**  Great Mass Getaway, a 150 mile bike ride from **
**  Boston to Provincetown.  Last year I raised   **
**  over $1200.  This year I would like to beat   **
**  that.  If you would like to contribute,       **
**  please contact me.                            **
**------------------------------------------------*/

