Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269732AbRHDBc7>; Fri, 3 Aug 2001 21:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269745AbRHDBcs>; Fri, 3 Aug 2001 21:32:48 -0400
Received: from mx1.afara.com ([63.113.218.20]:31571 "EHLO afara-gw.afara.com")
	by vger.kernel.org with ESMTP id <S269732AbRHDBcl>;
	Fri, 3 Aug 2001 21:32:41 -0400
Subject: Re: How does "alias ethX drivername" in modules.conf work?
From: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
To: Chris Wedgwood <cw@f00f.org>
Cc: Mark Atwood <mra@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010804132159.F18108@weta.f00f.org>
In-Reply-To: <m33d78de7d.fsf@flash.localdomain> 
	<20010804132159.F18108@weta.f00f.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 03 Aug 2001 18:32:18 -0700
Message-Id: <996888738.24442.1.camel@tduffy-lnx.afara.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 04 Aug 2001 01:29:32.0859 (UTC) FILETIME=[E9E738B0:01C11C84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 Aug 2001 13:21:59 +1200, Chris Wedgwood wrote:

> the kernel calls modprobe asking for the network device 'eth0',
> modprobe uses the configuration file to map this to a module

so, what happens when you have two eth cards that use the same module?
in the isa land, the order you pass the io=0x300,0x240 would determine
which order the eth?'s go to...how about in the pci world?

-tduffy

