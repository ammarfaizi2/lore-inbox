Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130201AbRBSWnM>; Mon, 19 Feb 2001 17:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130169AbRBSWnC>; Mon, 19 Feb 2001 17:43:02 -0500
Received: from theirongiant.zip.net.au ([61.8.0.198]:56846 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S130126AbRBSWms>; Mon, 19 Feb 2001 17:42:48 -0500
Date: Tue, 20 Feb 2001 09:42:19 +1100
From: CaT <cat@zip.com.au>
To: Dragan Stancevic <visitor@valinux.com>
Cc: Andrey Savochkin <saw@saw.sw.com.sg>, linux-kernel@vger.kernel.org
Subject: Re: eepro100 + 2.2.18 + laptop problems
Message-ID: <20010220094219.F365@zip.com.au>
In-Reply-To: <20010211224033.G352@zip.com.au> <20010213092638.A11218@saw.sw.com.sg> <20010213151409.Q352@zip.com.au> <20010220092106.D365@zip.com.au> <20010219153702.C24311@valinux.com> <20010220093301.E365@zip.com.au> <20010219154410.A10730@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010219154410.A10730@valinux.com>; from visitor@valinux.com on Mon, Feb 19, 2001 at 03:44:10PM -0800
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2001 at 03:44:10PM -0800, Dragan Stancevic wrote:
> On Tue, Feb 20, 2001, CaT <cat@zip.com.au> wrote:
> ; 
> ; None. This is before any traffic gets put through it. At worst the
> ; card has the wrong IP for the network but that is not always the case
> ; from memory.
> 
> So where does that card get the address from, are you doing DHCP?

Set manually. In debian-speak: ifup eth0 where:

iface eth0 inet static
	address 10.1.1.2
	netmask 255.255.255.0
	network 10.1.1.0
	broadcast 10.1.1.255
	gateway 10.1.1.1

So basically that does an ifconfig and route command I believe (or the 
equivalent)

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

