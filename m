Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265535AbSJXQeP>; Thu, 24 Oct 2002 12:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265536AbSJXQeP>; Thu, 24 Oct 2002 12:34:15 -0400
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:35311
	"EHLO columba.www.eur.3com.com") by vger.kernel.org with ESMTP
	id <S265535AbSJXQd7>; Thu, 24 Oct 2002 12:33:59 -0400
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: lkoverrun@yahoo.com
cc: linux-kernel@vger.kernel.org
Message-ID: <80256C5C.005B9080.00@notesmta.eur.3com.com>
Date: Thu, 24 Oct 2002 17:39:54 +0100
Subject: Re: Brust data send problem on gigabit NIC on Linux
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>I try to send out as many as
 >possible 15Kbyte-long ethernet packets to try to
> utilize the giga-bit/sec bandwidth

If you just want to generate packets then try pktgen in Linux-2.4.19:

CONFIG_NET_PKTGEN
  This module will inject preconfigured packets, at a configurable
  rate, out of a given interface.  It is used for network interface
  stress testing and performance analysis.  If you don't understand
  what was just said, you don't need it: say N.

  Documentation on how to use the packet generator can be found
  at <file:Documentation/networking/pktgen.txt>.

  This code is also available as a module called pktgen.o ( = code
  which can be inserted in and removed from the running kernel
  whenever you want).  If you want to compile it as a module, say M
  here and read <file:Documentation/modules.txt>.



