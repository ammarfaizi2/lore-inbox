Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTDTFHI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 01:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTDTFHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 01:07:08 -0400
Received: from uidc1-125.inav.uiowa.net ([64.6.87.125]:1920 "EHLO
	digitasaru.net") by vger.kernel.org with ESMTP id S263527AbTDTFHH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 01:07:07 -0400
Date: Sun, 20 Apr 2003 00:18:52 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: toshiba 1605/1625 hibernation issues [problem with ALi 15x3 driver]
Message-ID: <20030420051850.GA1118@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030412033232.GB887@digitasaru.net> <1050157975.16006.38.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050157975.16006.38.camel@dhcp22.swansea.linux.org.uk>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Alan Cox on Saturday, 12 April, 2003:
>On Sad, 2003-04-12 at 04:32, Joseph Pingenot wrote:
>> Well, actually, it's a workaround, not a fix.
>> Remove support for the ALi 15x3 chipset support (under IDE drivers).  Just
>>   use the generic.
>You probably need to hdparm -d0 /dev/hda before suspending and hdparm
>-d1 after resuming. I would guess your BIOS doesnt know how to keep the
>IDE state straight.

I just tried that; no dice.  :(
Any other ideas?

I think this bios is particularly brain damaged, but, since It Works with
  Windows, I get no help from Toshiba.  :(

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
" I'm all for using the best tool for the job, but what happens when the
 restrictions that go along with that tool take away your rights? I believe
 it then stops being the best tool for the job."  --randy@digitalrights.org
