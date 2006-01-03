Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWACCrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWACCrj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 21:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWACCrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 21:47:39 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:45991 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750793AbWACCri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 21:47:38 -0500
Date: Mon, 02 Jan 2006 21:47:32 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: mtrr: 0xe4000000,0x4000000 overlaps existing 0xe4000000,0x800000
In-reply-to: <Pine.LNX.4.62.0601021539550.1829@grinch.ro>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200601022147.33015.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <1136173074.6553.2.camel@mindpipe>
 <43B929C5.6050602@rainbow-software.org>
 <Pine.LNX.4.62.0601021539550.1829@grinch.ro>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 January 2006 08:40, caszonyi@rdslink.ro wrote:
>On Mon, 2 Jan 2006, Ondrej Zary wrote:
>> Lee Revell wrote:
>>> I got this in dmesg with 2.6.14-rc7 when I restarted X with
>>> ctrl-alt-backspace due to a lockup.  Is it a kernel bug or an X
>>> problem?
>>
>> I see that always when starting X:
>> mtrr: 0xe1000000,0x800000 overlaps existing 0xe1000000,0x400000
>
>Same here
>mtrr: 0xd0000000,0x8000000 overlaps existing 0xd0000000,0x2000000
>
>It appeared around kernel 2.6.14
>
And I've built and ran virtually every kernel from 2.6.14 to 2.6.15-rc7 
without encountering that message.  Ati 9200SE card, 128 megs of ram.  
Athlon 32 bitter running at a real clock speed of 2100mhz.

>
>--
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
