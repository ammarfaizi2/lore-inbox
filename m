Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316635AbSFZPVb>; Wed, 26 Jun 2002 11:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316636AbSFZPVa>; Wed, 26 Jun 2002 11:21:30 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6536 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316635AbSFZPV2>; Wed, 26 Jun 2002 11:21:28 -0400
Date: Wed, 26 Jun 2002 11:23:41 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Shawn Starr <spstarr@sh0n.net>
cc: alexander.riesen@synopsys.COM,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MCE Error - 2.5.24 - Whats this?
In-Reply-To: <1025103458.31334.1.camel@unaropia>
Message-ID: <Pine.LNX.3.95.1020626111937.25673A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jun 2002, Shawn Starr wrote:

> I don't understand that decoded result ;) 
> 
> Is it a phony result or is there a real problem with the CPU itself?
> It's brand new!
> 

It looks to me like a ECC error in external tag RAM (part of the
external cache).

The CPU is fine, but since it already read bad data from the cache,
it can't be allowed to restart.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

