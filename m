Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264776AbSKAMAE>; Fri, 1 Nov 2002 07:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbSKAMAE>; Fri, 1 Nov 2002 07:00:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47289 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264776AbSKAMAD>;
	Fri, 1 Nov 2002 07:00:03 -0500
Date: Fri, 1 Nov 2002 13:06:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd still borken for me in 2.5.45
Message-ID: <20021101120618.GJ8428@suse.de>
References: <Pine.LNX.4.44.0211010537410.917-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211010537410.917-100000@dad.molina>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01 2002, Thomas Molina wrote:
> I have been building my system to use ide-scsi for ages now because of 
> reqiurements for cdrecord.  With the announced intention to get rid of 
> ide-scsi in 2.5.44 I have started trying ide-cd with no success.  I 
> previously reported this problem for 2.5.44 and 2.5.45 continues the 
> issue.  My system is based on RedHat 7.3, with an A7V133 motherboard and 
> an Athlon 1.3GHz processor.  
> 
> Building ide-cd monolithic (or modular and attempting a modprobe) gives me 
> endless streams of the following error messages (hand-copied from 
> console):
> 
> hdc: irq timeout: status=0x90 {Busy}
> hdc: irq timeout: error=0x01IllegalLengthIndication
> hdc: drive not ready for command
> hdc: ATAPI reset timed-out, status=0x80
> ide1: reset: success

Interesting. Please send me a detailed list of your hardware, boot
messages should suffice. Does 2.5.43 work correctly?

-- 
Jens Axboe

