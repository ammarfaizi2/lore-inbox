Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269933AbRHJPk1>; Fri, 10 Aug 2001 11:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269941AbRHJPkR>; Fri, 10 Aug 2001 11:40:17 -0400
Received: from quattro.sventech.com ([205.252.248.110]:27654 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S269933AbRHJPkB>; Fri, 10 Aug 2001 11:40:01 -0400
Date: Fri, 10 Aug 2001 11:40:12 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Mike Jadon <mikej@umem.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI NVRAM Memory Card
Message-ID: <20010810114011.X3126@sventech.com>
In-Reply-To: <5.1.0.14.0.20010622101907.03ac21b0@192.168.0.5> <m17kwctghx.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <m17kwctghx.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Fri, Aug 10, 2001 at 03:24:10AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2001, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Mike Jadon <mikej@umem.com> writes:
> 
> > My company has released a PCI NVRAM memory card but we haven't developed a Linux
> > 
> > driver for it yet.  We want the driver to be open to developers to build upon.
> > Is there a specific path we should follow with this being our goal?  
> 
> You might want to check out the development of the mtd subsystem.
> http://www.linux-mtd.infradead.org/
> 
> This is probably what you want to write a driver for for your NVRAM PCI card.

Not really.

In their case, it's a bunch of standard SDRAM on a PCI card with a
battery backup. It's not flash.

A block device is all that's needed.

JE

