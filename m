Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264321AbRFQF1B>; Sun, 17 Jun 2001 01:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264280AbRFQF0v>; Sun, 17 Jun 2001 01:26:51 -0400
Received: from juicer38.bigpond.com ([139.134.6.95]:1522 "EHLO
	mailin7.bigpond.com") by vger.kernel.org with ESMTP
	id <S264321AbRFQF0k>; Sun, 17 Jun 2001 01:26:40 -0400
Message-Id: <m15BVAM-001UIzC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: hch@caldera.de (Christoph Hellwig)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] HotPlug CPU patch against 2.4.5 
In-Reply-To: Your message of "Sat, 16 Jun 2001 15:59:26 +0200."
             <200106161359.f5GDxQ214335@ns.caldera.de> 
Date: Sun, 17 Jun 2001 15:32:06 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200106161359.f5GDxQ214335@ns.caldera.de> you write:
> In article <m15BG8K-001UIwC@mozart> you wrote:
> > 	# Up...
> >	echo 1 > /proc/sys/cpu/1
> 
> Wouldn't /proc/sys/cpu/<num>/enable be better?  This way other per-cpu
> sysctls could be added more easily...

Yep.  But rewrite the sysctl crap first to make dynamically adding and
deleting entries sane.

Cheers,
Rusty.
--
Premature optmztion is rt of all evl. --DK
