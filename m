Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbUDNEzE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 00:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263881AbUDNEzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 00:55:04 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:15832 "EHLO
	zircon.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263880AbUDNEy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 00:54:59 -0400
Message-ID: <407CC3DB.3070300@us.ibm.com>
Date: Tue, 13 Apr 2004 23:53:47 -0500
From: Jon Grimm <jgrimm2@us.ibm.com>
Organization: IBM
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ross Dickson <ross@datscreative.com.au>, linux-kernel@vger.kernel.org,
       phil.el@wanadoo.fr
Subject: Re: io_apic & timer_ack fix
References: <200404100337.21730.ross@datscreative.com.au> <Pine.LNX.4.55.0404131412101.15949@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0404131412101.15949@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:

>On Sat, 10 Apr 2004, Ross Dickson wrote:
>
>> > Was it determined that the fix was bogus? damaging? fixable? 
>> 
>>I thought the patch was OK with typos fixed.
>>    
>>
>
> I consider it final.
>  
>
I 've been running the patch on a 2.4.21 code base.  I note that 
/proc/interrupts shows NMI interrupts coming in fast and furious, where 
without it there were none.   I'm not sure what to think of  this.

Any idea whether this could/should be expected?

Best Regards,
Jon


