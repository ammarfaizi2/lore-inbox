Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317287AbSFLBAt>; Tue, 11 Jun 2002 21:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317289AbSFLBAs>; Tue, 11 Jun 2002 21:00:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1547 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317287AbSFLBAs>;
	Tue, 11 Jun 2002 21:00:48 -0400
Message-ID: <3D069C69.1090003@mandrakesoft.com>
Date: Tue, 11 Jun 2002 20:57:13 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Donald Becker <becker@scyld.com>
CC: Matti Aarnio <matti.aarnio@zmailer.org>,
        Robert PipCA <robertpipca@yahoo.com>, vortex@scyld.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [vortex] Re: MTU discovery
In-Reply-To: <Pine.LNX.4.33.0206111523050.1688-100000@presario>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Donald Becker wrote:
> A 16 bit register.. 64KB packets.  There are various issues with using
> large packet sizes.  There is no driver that has been verified with
> jumbo frames.  I have been throwing driver versions at Rishi Srivatsavai
> <rishis at CLEMSON.EDU> trying to sort out the issues.  You might notice
> the changes in 0.99W, although they don't handle the FIFO limit issues.


With the VLAN stuff that suddenly appeared, I did some large packet 
testing...  I would typically cap the MTU limit at just under the FIFO 
size, since it often requires special handling doing frames > FIFO size.

I do not look forward to re-verifying the 2.4 tulip driver across all 
those chipsets, to make sure my large packet code [which is not yet in 
the kernel] works. :)

	Jeff



