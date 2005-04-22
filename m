Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVDVLc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVDVLc1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 07:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVDVLc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 07:32:26 -0400
Received: from [203.197.150.194] ([203.197.150.194]:728 "EHLO
	bhadra.amrita.ac.in") by vger.kernel.org with ESMTP id S261994AbVDVLcD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 07:32:03 -0400
X-Antivirus-Amrita-Mail-From: harish@amritapuri.amrita.edu via bhadra.amrita.ac.in
X-Antivirus-Amrita: 1.24-st-qms (Clear:RC:1(127.0.0.1):. Processed in 0.032746 secs Process 18459)
Message-ID: <47196.203.197.150.195.1114171742.squirrel@mail.amrita.ac.in>
In-Reply-To: <20050420065751.GA9791@taniwha.stupidest.org>
References: <42225.203.197.150.195.1113980805.squirrel@mail.amrita.ac.in>
    <20050420065751.GA9791@taniwha.stupidest.org>
Date: Fri, 22 Apr 2005 17:39:02 +0530 (IST)
Subject: Re: i830 lockup
From: "Harish K Harshan" <harish@amritapuri.amrita.edu>
To: "Chris Wedgwood" <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Reply-To: harish@amritapuri.amrita.edu
User-Agent: SquirrelMail/1.4.4-1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chris,

   But the system works pretty fine when other applications are running.
Oncei load the driver, the system gets messed up. Could it be the
problem with the way I handle DMA and interrupts?? I mean, is it
possible to mess up everything by wrong programming??? This driver
works prefectly on the other IPCs we have, but not on the two-piece
board (Chino-Laxons) systems we have. The DMA channels are both free
before loading the drivers all the time, and one it is loaded, the
/proc/dma file shows the DMA has been hooked properly. Could it still
be the problem with the CPU/Cache/Chipset as you said? If yes, then why
is it throwing up the error only when I load the driver? Or is it
really the problem with the driver programming? Please let me know as
soon as possible.

Thank You in advance,
Harish K Harshan.

On Wed, April 20, 2005 12:27 pm, Chris Wedgwood said:
> On Wed, Apr 20, 2005 at 12:36:45PM +0530, Harish K Harshan wrote:
>
>> CPU 0 : Machine Check Exception : 0000000000000004
>> Bank 0 : a200000084010400
>> Kernel panic : CPU context corrupt
>> In interrupt handler - not syncing
>
> CPU got messed up...  could be a bad CPU/cache/chipset or simply it's
> over heating or has a bad powersupply.
>



-----------------------------------------
This email was sent using Amrita Mail.
   "Amrita Vishwa Vidyapeetham [Deemed University] - Amritapuri Campus"
http://amritapuri.amrita.edu

