Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270947AbRHXFgv>; Fri, 24 Aug 2001 01:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270948AbRHXFgm>; Fri, 24 Aug 2001 01:36:42 -0400
Received: from node-cffb924a.powerinter.net ([207.251.146.74]:48969 "HELO
	switchmanagement.com") by vger.kernel.org with SMTP
	id <S270947AbRHXFgY>; Fri, 24 Aug 2001 01:36:24 -0400
Message-ID: <3B85E7E2.7000602@switchmanagement.com>
Date: Thu, 23 Aug 2001 22:36:34 -0700
From: Brian Strand <bstrand@switchmanagement.com>
Organization: Switch Management
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: support@3ware.com
Subject: 3ware: no cards found in 2.2.19, cards found in 2.4.x
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a quad xeon 2GB system running Oracle which I am reverting to 
2.2.x because of 2.4.x's less than desirable VM performance (causing a 
2x Oracle slowdown, reported about a month ago on linux-kernel).  I 
foolishly put a 3ware card in at the same time as I "upgraded" the box 
to 2.4.4, so now I am in the undesirable position of needing to go back 
to 2.2.19, but that kernel cannot find the card.  I get the following 
message during boot:

3w-xxxx: tw_find_cards(): No cards found
/lib/moduless/2.2.19-2GB-SMP/scsi/3w-xxxx.o: init_module: Device or 
resource busy

I have tried compiling the 3ware driver version 1.02.00.{004,006,007} 
all with the same result.  Has anyone managed to use a Suse 2.2.19 
kernel with 3ware cards with any success?  The 1.02.00.004 driver is 
from the stock 2.2.19 kernel, the .006 driver is from 3ware's website, 
and the .007 driver is from 2.2.20pre9.

Any hints appreciated,
Brian Strand
CTO Switch Management


