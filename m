Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318313AbSG3P5n>; Tue, 30 Jul 2002 11:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318307AbSG3P5n>; Tue, 30 Jul 2002 11:57:43 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:25861 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318313AbSG3P5i>;
	Tue, 30 Jul 2002 11:57:38 -0400
Date: Tue, 30 Jul 2002 08:59:42 -0700
From: Greg KH <greg@kroah.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Stuart MacDonald <stuartm@connecttech.com>,
       Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: [parisc-linux] 3 Serial issues up for discussion (was: Re: Serial core problems on embedded PPC)
Message-ID: <20020730155942.GD15359@kroah.com>
References: <20020729040824.GA2351@zax> <20020729100009.A23843@flint.arm.linux.org.uk> <20020729144408.GA11206@opus.bloom.county> <20020729181702.E25451@flint.arm.linux.org.uk> <20020729231927.D3317@parcelfarce.linux.theplanet.co.uk> <008801c237d6$8b7dc640$294b82ce@connecttech.com> <20020730161940.P1441@parcelfarce.linux.theplanet.co.uk> <00f801c237df$d09d4e40$294b82ce@connecttech.com> <20020730165351.C7677@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020730165351.C7677@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 02 Jul 2002 14:38:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 04:53:51PM +0100, Russell King wrote:
> 2. USB devices want "packets" of data to write rather than the ring-
>    buffer we currently use for UARTs.

The driver could be changed to handle a ring buffer, if it's too tough.
As long as it's ok to grab a very large chunk of data out of the ring
buffer all at once :)

Time to look at the serial changes more closely...

thanks,

greg k-h
