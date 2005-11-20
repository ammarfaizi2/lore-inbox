Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVKTHXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVKTHXM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 02:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVKTHXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 02:23:12 -0500
Received: from nbg01-smtpauth-04.lumison.net ([87.246.68.12]:5297 "EHLO
	nbg01-smtpauth-04.lumison.net") by vger.kernel.org with ESMTP
	id S1750757AbVKTHXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 02:23:12 -0500
Date: Sun, 20 Nov 2005 07:22:59 +0000 (GMT)
From: asmith@vtrl.co.uk
To: linux-kernel@vger.kernel.org
Subject: Re: Does Linux support powering down SATA drives?
In-Reply-To: <200511192304.16302.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.61.0511200718530.25549@vtrl22.vtrl.co.uk>
References: <437F63C1.6010507@perkel.com> <1132431907.19692.15.camel@localhost.localdomain>
 <437F9705.80503@perkel.com> <200511192304.16302.s0348365@sms.ed.ac.uk>
Organization: Valley Technology Research Ltd
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would agree with your view on IDE becoming obsolete on hard drives, but I as 
yet, am not aware of any CD/DVD drives with a SATA interface.




On Sat, 19 Nov 2005, Alistair John Strachan wrote:

> On Saturday 19 November 2005 21:20, Marc Perkel wrote:
> [snip]
>>
>> SATA isn't really "new" any more. I personally consider IDE to be
>> obsolete. Seems to me that Linux should fully support SATA to the same
>> level as IDE drives. And I'm saying that as someone who doesn't have to
>> actually code it. But I will leave messages of praise and thanks in this
>> mailing list if you all catch up.
>
> As Alan mentions in another thread, what is needed is true hotplug support,
> which is difficult with some controllers for which we have poor (or no)
> documentation. I wouldn't hold your breath.
>
> As for pass-thru standby/sleep commands, as long as the pass-thru patch got
> into mainline, try a very recent version of hdparm which should understand
> sending the ATA commands over SCSI (libata).
>
>
