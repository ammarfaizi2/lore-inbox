Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269709AbTGKAos (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 20:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269725AbTGKAos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 20:44:48 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:33412 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S269709AbTGKAop
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 20:44:45 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Greg KH <greg@kroah.com>
Subject: Re: USB stops working with any of 2.4.22-pre's after 2.4.21
Date: Thu, 10 Jul 2003 20:59:21 -0400
User-Agent: KMail/1.5.1
Cc: John Wong <kernel@implode.net>, linux-kernel@vger.kernel.org
References: <20030710065801.GA351@gambit.implode.net> <200307101851.14757.gene.heskett@verizon.net> <20030711001253.GB15317@kroah.com>
In-Reply-To: <20030711001253.GB15317@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307102059.21905.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.62.27] at Thu, 10 Jul 2003 19:59:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 July 2003 20:12, Greg KH wrote:
>On Thu, Jul 10, 2003 at 06:51:14PM -0400, Gene Heskett wrote:
>> T:  Bus=02 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  6 Spd=12  MxCh= 0
>> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
>> P:  Vendor=1453 ProdID=4026 Rev= 0.00
>> C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=500mA
>> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00
>> Driver=serial E:  Ad=81(I) Atr=03(Int.) MxPS=  10 Ivl=1ms
>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> E:  Ad=83(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>
>Looks ok, the device probably just doesn't have any string
> descriptors (or any valid ones at least.)
>
>It should not affect the operation of the device, right?
>
>greg k-h

It must be time for me to see if I can find enough 9 to 25 pin 
adaptors and stick an led sniffer in the line then, because I cannot 
talk to the trs80 Color Computer on the other end of the cable.

I'll be back on this if I find anything interesting.  Of more interest 
is the fact that the belkin bulldog kits upsd cannot talk to 
/dev/ttyS1 although it is picking up data from the port.  It outputs 
on localhost:2710 but its only the keep-alive chatter from the ups.  
Apparently no commands can be sent to the ups.

This however, is a seriel port problem, not usb.  I was sort of hoping 
there might be a common thread to the failures. :)

-- 
Cheers Greg, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

