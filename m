Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318138AbSGRPiZ>; Thu, 18 Jul 2002 11:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318140AbSGRPiZ>; Thu, 18 Jul 2002 11:38:25 -0400
Received: from crisium.vnl.com ([194.46.8.33]:22541 "EHLO crisium.vnl.com")
	by vger.kernel.org with ESMTP id <S318138AbSGRPiY>;
	Thu, 18 Jul 2002 11:38:24 -0400
Date: Thu, 18 Jul 2002 16:45:33 +0100
From: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.kernel.org
Cc: Frank Davis <fdavis@si.rr.com>
Subject: 2.5.26 : drivers/scsi/BusLogic.c
Message-ID: <20020718154533.GA6851@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org,
	Frank Davis <fdavis@si.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>As noted below, Frank Davis suggests I fire this back into the
>list for discussion.
>
>On Thu, Jul 18, 2002 at 11:04:17AM -0400, Frank Davis wrote:
>
>>Dale,
>> Here's what I know....
>>not all architectures define an 'address' variable in the struct 
>>scatterlist, so some archs will compile with no problems, others won't. 
>>If you're using a i386, there isn't an address variable. Here's what I 
>>suggest....email linux-kernel with the problem report for 2.5.26, and 
>>explain what I have stated above. I could have a bunch of #ifdef for 
>>each arch, but thats plain crazy. I'd be interested in what some other 
>>developers suggest. Sorry, I couldn't provide you a patch.
>>
>>Regards,
>>Frank
>>

BusLogic.c:32: #error Please convert me to Documentation/DMA-mapping.txt
BusLogic.c: In function `BusLogic_DetectHostAdapter':
BusLogic.c:2841: warning: long unsigned int format, BusLogic_IO_Address_T arg (arg 2)
BusLogic.c: In function `BusLogic_QueueCommand':
BusLogic.c:3415: structure has no member named `address'
BusLogic.c: In function `BusLogic_BIOSDiskParameters':
BusLogic.c:4141: warning: implicit declaration of function `scsi_bios_ptable'
BusLogic.c:4141: warning: assignment makes pointer from integer without a cast
make[2]: *** [BusLogic.o] Error 1

