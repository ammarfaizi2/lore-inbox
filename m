Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133002AbRDLF0a>; Thu, 12 Apr 2001 01:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133029AbRDLF0V>; Thu, 12 Apr 2001 01:26:21 -0400
Received: from mpdr0.chicago.il.ameritech.net ([206.141.239.142]:10704 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S133002AbRDLF0N>; Thu, 12 Apr 2001 01:26:13 -0400
Message-ID: <3AD53C66.92B8D6BE@ameritech.net>
Date: Thu, 12 Apr 2001 00:25:58 -0500
From: watermodem <aquamodem@ameritech.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac24 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: No 100 HZ timer !
In-Reply-To: <E14n0J3-0004U6-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Timers more precise than 100HZ aren't probably needed - as MIN_RTO is 0.2s
> > and MIN_DELACK is 0.04s, TCP would hardly benefit from them.
> 
> There are a considerable number of people who really do need 1Khz resolution.
> Midi is one of the example cases. That doesn't mean we have to go to a 1KHz
> timer, we may want to combine a 100Hz timer with a smart switch to 1Khz

As somebody who is now debating how to measure latencies in a 
giga-bit ethernet environment with several components doing 
L3 switching in much less than 10 micro-seconds ... (hardware)
I agree that some method is need to achieve higher resolutions.  
(Sigh... I will likely need to buy something big and expensive)
{this is for a system to make use of L. Yarrow's little protocol}
