Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261962AbTC1Csk>; Thu, 27 Mar 2003 21:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261981AbTC1Csj>; Thu, 27 Mar 2003 21:48:39 -0500
Received: from ns0.usq.edu.au ([139.86.2.5]:4358 "EHLO ns0.usq.edu.au")
	by vger.kernel.org with ESMTP id <S261962AbTC1Csj>;
	Thu, 27 Mar 2003 21:48:39 -0500
Message-ID: <3E83BB8E.6050303@usq.edu.au>
Date: Fri, 28 Mar 2003 13:03:42 +1000
From: Ron House <house@usq.edu.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: hdparm and removable IDE?
References: <3E812F8E.2030200@usq.edu.au> <1048689184.31839.7.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Wed, 2003-03-26 at 04:41, Ron House wrote:
> 
>>The scenario: I have a ViPower hot-swap mobile rack for swapping IDE HDs 
>>on the fly. I am assuming that this device properly disconnects the 
>>hardware and that I am faced with a software problem. Our technical 
>>staff tell me that they have 'tested' hot swapping under RedHat 7.3 
>>(Kernel 2.4.18-3) and it 'works'. In other words, they unmounted, 
>>swapped, and mounted a new disk and didn't observe data loss. I am sure
> 
> 
> IDE hotswap at drive level is not supported by Linux. It might work ok. 
> Providing you shut the drive down fully and flush the cache before you
> unregister/unplug and replug before registering the new interface

Thanks Alan. What is needed to do this? Is umounting and then 
unregistering with hdparm -U enough to do this, or is something else needed?

-- 
Ron House     house@usq.edu.au
               http://www.sci.usq.edu.au/staff/house

