Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265433AbRF0WTB>; Wed, 27 Jun 2001 18:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265435AbRF0WSz>; Wed, 27 Jun 2001 18:18:55 -0400
Received: from 24-25-197-107.san.rr.com ([24.25.197.107]:2835 "HELO
	acmay.homeip.net") by vger.kernel.org with SMTP id <S265433AbRF0WSf>;
	Wed, 27 Jun 2001 18:18:35 -0400
Date: Wed, 27 Jun 2001 15:18:29 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is the best way for multiple net_devices
Message-ID: <20010627151829.B23834@ecam.san.rr.com>
In-Reply-To: <20010627145201.A23834@ecam.san.rr.com> <3B3A5852.AAEF9531@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3B3A5852.AAEF9531@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2001 at 06:04:02PM -0400, Jeff Garzik wrote:
> andrew may wrote:
> > 
> > Is there a standard way to make multiple copies of a network device?
> > 
> > For things like the bonding/ipip/ip_gre and others they seem to expect
> > insmod -o copy1 module.o
> > insmod -o copy2 module.o
> 
> The network driver should provide the capability to add new devices.

I am planning to write or patch some drivers to do this as well as other
things. 

I would want to add things at run time after the module is alreaded loaded.
So options to the module won't work.

I don't know how to use ifconfig to create a new device.

Any examples of drivers and apps that do this cleanly. The ones I have
seen are not.
