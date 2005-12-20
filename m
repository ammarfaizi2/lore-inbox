Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbVLTJGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVLTJGZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 04:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbVLTJGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 04:06:25 -0500
Received: from [202.125.80.34] ([202.125.80.34]:24588 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S1750892AbVLTJGY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 04:06:24 -0500
Subject: RE: Kernel interrupts disable at user level - RIGHT/ WRONG - Help
Date: Tue, 20 Dec 2005 14:32:07 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <3AEC1E10243A314391FE9C01CD65429B2232A4@mail.esn.co.in>
X-MS-Has-Attach: 
Content-class: urn:content-classes:message
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Thread-Topic: Kernel interrupts disable at user level - RIGHT/ WRONG - Help
Thread-Index: AcYFM+JLj1FoHgF2TzWRU3Jyr96l8wAECSKw
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Dave Jones" <davej@redhat.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Dave Jones [mailto:davej@redhat.com]
> Sent: Tuesday, December 20, 2005 12:39 PM
> To: Mukund JB.
> Cc: Alan Cox; linux-kernel@vger.kernel.org
> Subject: Re: Kernel interrupts disable at user level - RIGHT/ WRONG -
> Help
> 
> 
> On Tue, Dec 20, 2005 at 12:27:13PM +0530, Mukund JB. wrote:
>  > 
>  > Dear Alan,
>  > 
>  > I want the contents of A, B, C, D registers of CMOS mapped 
> registers.
>  > But instead the driver gives the details about the bit 
> masks of few of register A, B only.
>  > The others are NOT available. 
>  > 
>  > I would also require to retrieve the day of the week info 
> in RTC information. 
>  > I tried the /dev/rtc but I don't get it there.
> 
> Use /dev/nvram instead.
> 
> 		Dave

/dev/nvram does not give the cpomplete CMOS details. A part of RTC & date, tine and other info will be missing.

Regards,
Mukund Jampala

