Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161204AbWALTs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161204AbWALTs1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbWALTs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:48:27 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:37021 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1161204AbWALTs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:48:27 -0500
Date: Thu, 12 Jan 2006 14:48:25 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.1[4,5]: battery info lost
In-reply-to: <43C6AB66.2040509@liberouter.org>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200601121448.25776.gene.heskett@verizon.net>
Organization: Absolutely none - usually detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20060112173752.GN16769@wptx44.physik.uni-wuerzburg.de>
 <43C6AB66.2040509@liberouter.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 January 2006 14:17, Jiri Slaby wrote:
>Alexander Wagner napsal(a):
>> Problem: Linux seems to loose the battery information in recent
>> kernels.
>>
>> Keywords: Battery, ACPI, 2.6.14.x, 2.6.15
>>
>> Description:
>>
>> Since 2.6.14 I notice that after some time the Kernel seems
>> to loose the battery information via ACPI. This behaviour
>> is reproducable though I do not know how to provoke it (it
>> just happens). Occurs as well on the R52 from which are the
>> logs below as on my T41p. On LKML this problem seems also
>> to be mentioned by Narayan Desai and the same issues seems
>> to be reported by Alejandro Bonilla Beeche and Geoff Mishkin
>> mentioning this problem on other IBMs. As the latter uesed
>
>Me too with 2.6.15 on asus m6r. In 2.6.14 helped ec_burst=1 kernel
> parameter. I will try few things with that and let you know (tomorrow
> or the day after). It is broken since 2.6.14 times, IIRC 2.6.13 was
> OK.
>I have also problems with irqs I found out yesterday. Don't know if it
> does have sth. to do with this [acpi] problem (I mean LOC: 4394987,
> ERR: 891474, timer is 4394964).
>
>regards,

Just to provide a data point, this is a biostar board and gkrellm 
displays the cmos battery voltage as 3.14 volts right now, booted to 
2.6.15.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
