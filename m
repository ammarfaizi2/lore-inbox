Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317935AbSGWM7S>; Tue, 23 Jul 2002 08:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318049AbSGWM7S>; Tue, 23 Jul 2002 08:59:18 -0400
Received: from bru-cse-369.cisco.com ([144.254.12.31]:33256 "EHLO
	bru-cse-369.cisco.com") by vger.kernel.org with ESMTP
	id <S317935AbSGWM7R>; Tue, 23 Jul 2002 08:59:17 -0400
Date: Tue, 23 Jul 2002 15:02:21 +0200
From: Marc Duponcheel <mduponch@cisco.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19rc2 -> 2.4.19rc3 : no more eth
Message-ID: <20020723130221.GF29367@cisco.com>
Reply-To: Marc Duponcheel <mduponch@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Cisco Systems
X-uname: SunOS 5.8 sun4u
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel crew.

I follow the stable kernel and run 2.4.18 just fine on 3 machines.

Recently I thought about trying 2.4.19rc kernels.  That went fine as
well with one exception.

One machine (with 2 ethernet controllers)
 Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0c)
 3Com Corporation 3c900B-TPO [Etherlink XL TPO] (rev 04)
will no longer recognise -any- of those.

Note that this 'artifact' only happens with 2.4.19rc3.  The .config
between 2.4.19rc2 did not change 2.4.19rc3

During boot I see OOPses (which for some reason, my syslog does not
see).

Because this is a rather severe change [:-)] I wonder if I this rings
a bell.

Thanks for your valuable time

--
 Greetings,

Marc Duponcheel     Multicast Development Engineer      Cisco Systems
email: mduponch@cisco.com tel: +32 2 704 52 40 cell: +32 478 68 10 91
