Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289832AbSBOPEJ>; Fri, 15 Feb 2002 10:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289855AbSBOPD7>; Fri, 15 Feb 2002 10:03:59 -0500
Received: from dsl-65-188-226-101.telocity.com ([65.188.226.101]:27910 "HELO
	fancypants.trellisinc.com") by vger.kernel.org with SMTP
	id <S289832AbSBOPDq>; Fri, 15 Feb 2002 10:03:46 -0500
Date: Fri, 15 Feb 2002 10:03:42 -0500
From: Jason Lunz <j@trellisinc.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
Message-ID: <20020215150342.GA4347@trellisinc.com>
In-Reply-To: <E16bhwo-0007GZ-00@bronto.zrz.TU-Berlin.DE> <3C6D07B9.596AD49E@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C6D07B9.596AD49E@mandrakesoft.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mlist.linux-kernel, you wrote:
> Cuz the driver is a piece of crap, and BroadCom isn't interested in
> working with the open source community to fix up the issues.

Can you elaborate? What are the issues? I've found the broadcomm driver
to be more robust than the in-kernel one for acenic cards. With acenic,
I've had a null-pointer deref on SMP and other lockups where I wasn't
lucky enough to get an oops.

Also, broadcomm-driven cards can be put in a bridge. An acenic/bridge
combination will crash the kernel hard when tcp traverses the bridge.

> DaveM and I should have something eventually, which will make the
> RH-shipped driver irrelevant.

that would be oh-so-nice. Do you need cards to play with? I've got a
couple of 3com broadcomm-chipset cards I prabably won't be needing.

-- 
Jason Lunz		Trellis Network Security
j@trellisinc.com	http://www.trellisinc.com/
