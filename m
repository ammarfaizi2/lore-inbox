Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265141AbUELSBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUELSBZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265146AbUELSBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:01:24 -0400
Received: from fmr11.intel.com ([192.55.52.31]:34492 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S265141AbUELSBR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:01:17 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
x-mimeole: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Write-combining
Date: Wed, 12 May 2004 11:00:49 -0700
Message-ID: <468F3FDA28AA87429AD807992E22D07EFA1E7F@orsmsx408.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Write-combining
Thread-Index: AcQ3k1Mj+9nZs8gYRAesMes4P+Nv6QAt2iBQ
From: "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>
To: "Thiago Robert" <robert@inf.ufsc.br>, "Sean Neakums" <sneakums@zork.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 May 2004 18:00:50.0832 (UTC) FILETIME=[0F94A900:01C4384B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lspci -vvv for your device should display the device specific BARs. If
you see the corresponding BAR in /proc/mtrr display it means that it is
MTRR mapped device memory.

Thanks,
ganesh 
 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Thiago Robert
Sent: Tuesday, May 11, 2004 11:43 AM
To: Sean Neakums
Cc: linux-kernel@vger.kernel.org
Subject: Re: Write-combining

Is anyone certain about this?

Thanks in advance.

_________________________
Thiago Robert


Sean Neakums wrote:

>Thiago Robert <robert@inf.ufsc.br> writes:
>
>  
>
>>Is the default behaviour of the Linux kernel to enable
>>write-combining? How can I be sure if it is enabled or not?
>>    
>>
>
>My /proc/mtrr lists the following region:
>
>reg03: base=0xf8000000 (3968MB), size=  64MB: write-combining, count=2
>
>which I am guessing is the PCI space, although I'm not certain.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

