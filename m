Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310644AbSCHBsg>; Thu, 7 Mar 2002 20:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310642AbSCHBs0>; Thu, 7 Mar 2002 20:48:26 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:18827 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S310640AbSCHBsO>; Thu, 7 Mar 2002 20:48:14 -0500
Date: Thu, 7 Mar 2002 19:47:58 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: John Jasen <jjasen1@umbc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recommendations about a 100/10 NIC
Message-ID: <20020307194758.A5904@asooo.flowerfire.com>
In-Reply-To: <20020306111502.D8107@asooo.flowerfire.com> <Pine.SGI.4.31L.02.0203061234520.6241227-100000@irix2.gl.umbc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SGI.4.31L.02.0203061234520.6241227-100000@irix2.gl.umbc.edu>; from jjasen1@umbc.edu on Wed, Mar 06, 2002 at 12:36:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SMC cards used to be Tulip before epic.  I had the same module
problems with epic too, so we had to go to EE from Tulip when that
happened. :(

I suspect a lot of the problems depend on the motherboard or
architecture, as well as the switching hardware.

-- 
Ken.
brownfld@irridia.com

On Wed, Mar 06, 2002 at 12:36:24PM -0500, John Jasen wrote:
| On Wed, 6 Mar 2002, Ken Brownfield wrote:
| 
| > Haven't had any issues at all with eepro100 or e100 under production
| > load for years.  Since Tulip went out of the mainstream (poor Digital)
| > the EtherExpress has been the most stable everywhere I've been.  I've
| > written too many scripts for 3Com boxes that grep dmesg for "fatal"
| > errors and unload/reload the 3com module.
| 
| Ran into problems with Intel EtherExpress cards under Alpha a while back,
| and I've had a _lot_ of problems with the revision of the EtherExpress
| built into motherboards, versus the intel or kernel drivers for them.
| 
| My stock recommendation is thus SMC EtherPower II cards.
| 
| --
| -- John E. Jasen (jjasen1@umbc.edu)
| -- In theory, theory and practise are the same. In practise, they aren't.
