Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310154AbSCSGAF>; Tue, 19 Mar 2002 01:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310155AbSCSF74>; Tue, 19 Mar 2002 00:59:56 -0500
Received: from angband.namesys.com ([212.16.7.85]:17538 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S310154AbSCSF7t>; Tue, 19 Mar 2002 00:59:49 -0500
Date: Tue, 19 Mar 2002 08:59:43 +0300
From: Oleg Drokin <green@namesys.com>
To: Christian Robert <christian.robert@polymtl.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to run kernel 2.4.18  it panic at boot
Message-ID: <20020319085943.B4750@namesys.com>
In-Reply-To: <3C96C714.E6967570@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Mar 19, 2002 at 12:05:24AM -0500, Christian Robert wrote:

> My root "/"       is on /dev/hde2  Maxstor 60 Gigs disk on Promise ATA/100 ide controller (2.01 build 27) 
> my boot "/boot"   is on /dev/hda1
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> FAT: bogus logical sector size 0
> FAT: bogus logical sector size 0
> and here it goes wrong, I type it from a piece of paper since it has not started to log to file and
> even ctrl-Page-Up is not working (machine completely jammed). I removed some leading zeroes. 
> 
> invalid operand: 0000
> CPU: 0
> EIP:  0010: [<c012dcdc>] not tainted

In ideal world you'd lookup this EIP value (And also all values from back trace
in your System.map file (either by ksymoops program or by hand).

Also double check you have reiserfs compiled into your kernel.

Bye,
    Oleg
