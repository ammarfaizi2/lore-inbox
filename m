Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbTELAWK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 20:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTELAWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 20:22:09 -0400
Received: from ns.indranet.co.nz ([210.54.239.210]:18903 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id S261669AbTELAWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 20:22:04 -0400
Date: Mon, 12 May 2003 12:34:36 +1200
From: Andrew McGregor <andrew@indranet.co.nz>
To: Tuncer M zayamut Ayaz <tuncer.ayaz@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
Message-ID: <443147.1052742876@[192.168.1.249]>
In-Reply-To: <17308.1052658225@www4.gmx.net>
References: <3191078.1052695705@[192.168.1.249]>
 <17308.1052658225@www4.gmx.net>
X-Mailer: Mulberry/3.0.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there...

--On Sunday, 11 May 2003 3:03 p.m. +0200 Tuncer M zayamut Ayaz 
<tuncer.ayaz@gmx.de> wrote:

>> Reasoning:
>> cpufreq and speedstep don't work on Dell P3 laptops anyway, and the
>> *internal power supplies* of the i8x00 series make wierd noises when APM
>> tries to idle the CPU.  The board will do this anyway, without making
>
> hmm, at least now I know where that strange sound comes from.
> I'm not quite sure that SpeedStep does not work,
> with SpeedStep disabled in the BIOS the fans turned on again with
> cpu load. this doesn't happen with SpeedStep. so I suppose it works
> to some extent, right?

Sounds like it to me.  It certainly does not work on my i8000, but the 8100 
is possibly different.

>
>> noise, so linux need not.
>
> so what options should I set?
> as I've already stated it's not bearable to do coding (incl. compiling)
> on this box without "Battery Optimized Mode" as SpeedStep calls it.
> on Linux I did that with a simple tool called speedstep.
> I've seen autospeedstep from Fritz Ganter which seems to use ACPI,
> dunno how that compares to cpufreqd.

Hmm.  Maybe the 8100 has working speedstep, then.  I'd suggest you see if 
disabling just the APM idle calls, but leaving speedstep and cpufreq on 
makes the noise.

I have had no success whatever with ACPI on an i8000, but again an 8100 may 
be different.

>
> anyway, this laptop is not-so-nice anyway, I'm just happy I didn't
> buy it but my employer did ;)

Same here, and I mostly agree.  Good price for such a nice screen, though 
(I have the 1600x1200 15" screen).

Andrew
