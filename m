Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289014AbSBIX5F>; Sat, 9 Feb 2002 18:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289017AbSBIX44>; Sat, 9 Feb 2002 18:56:56 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:59324 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S289014AbSBIX4j>; Sat, 9 Feb 2002 18:56:39 -0500
Date: Sun, 10 Feb 2002 00:56:36 +0100
From: bert hubert <ahu@ds9a.nl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ingress policing still not working in 2.4?
Message-ID: <20020210005636.A21350@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020209114529.GA6753@links2linux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020209114529.GA6753@links2linux.de>; from marc.schiffbauer@links2linux.de on Sat, Feb 09, 2002 at 11:48:50AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 11:48:50AM +0000, Marc Schiffbauer wrote:
> Hi all,
> 
> Is ingress policing not working in the current Kernel?
> 
> I'm using the Script from the Advanced Routing HOWTO
> (Thanks for that BTW!)
> 
> While trying to do a
> 
> # tc qdisc add dev ppp0 handle ffff: ingress
> 
> I get this:
> RTNETLINK answers: No such file or directory

Get a newer tc, it appears to fix this problem.

> Before that I successfully did this:
> # install root CBQ
> DEV=ppp0
> UPLINK=100
> DOWNLINK=750
> tc qdisc add dev $DEV root handle 1: cbq avpkt 1000 bandwidth 100mbit

The WonderShaper! 

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
Linux Advanced Routing & Traffic Control: http://ds9a.nl/lartc
