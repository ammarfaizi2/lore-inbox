Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319550AbSH3Lkx>; Fri, 30 Aug 2002 07:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319553AbSH3Lkx>; Fri, 30 Aug 2002 07:40:53 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:624 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S319550AbSH3Lkw>; Fri, 30 Aug 2002 07:40:52 -0400
From: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 30 Aug 2002 13:42:40 +0200
MIME-Version: 1.0
Subject: Re: PROBLEM: nfs & "Warning - running *really* short on DMA buffers"
CC: linux-kernel@vger.kernel.org
Message-ID: <3D6F7650.32578.A1B755@localhost>
References: <3D6F34B1.29073.4DAAB0@localhost>
In-reply-to: <1030705134.3180.9.camel@irongate.swansea.linux.org.uk>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   I do wan't to tune the vm settings, these warnings may not be 
fatal but it's not pretty to have hundreds of those in the console 
and log files. Bear with me on this one, but i remember doing exactly 
that in the past, tuning  /proc/sys/vm/freepages. How does one 
acomplish that nowadays? I looked at the kernel source documentation 
and still found references to freepages, but vm/freepages doesn't 
exist anymore. Kernel is 2.4.18-10 from Redhat. 


Regards,
Pedro

On 30 Aug 2002 at 11:58, Alan Cox wrote:

> On Fri, 2002-08-30 at 08:02, Pedro M. Rodrigues wrote:
> >    Hello to all! While preparing to migrate some servers to Redhat 
> > 7.3 and doing some nfs tests before deployment i came across this
> > "Warning - running *really* short on DMA buffers" error message
> > repeated several times in dmesg and /var/log/messages. Something
> > like this:
> 
> They are warnings not fatal, at most they slowed you down due to lack
> of resources. You might want to tune the vm settings to keep more
> pages reserved for atomic allocation
> 
> 


