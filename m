Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129296AbRBFOT1>; Tue, 6 Feb 2001 09:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129344AbRBFOTQ>; Tue, 6 Feb 2001 09:19:16 -0500
Received: from linuxcare.com.au ([203.29.91.49]:44812 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129296AbRBFOS7>; Tue, 6 Feb 2001 09:18:59 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Wed, 7 Feb 2001 01:17:25 +1100
To: lists@frednet.dyndns.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hot swap CPU support for 2.4.1@
Message-ID: <20010207011725.B15995@linuxcare.com>
In-Reply-To: <E14PcpU-0004U1-00@halfway> <20010205151917.A17110@frednet.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010205151917.A17110@frednet.dyndns.org>; from lists@frednet.dyndns.org on Mon, Feb 05, 2001 at 03:19:17PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Would any special hardware besides a multi-cpu system be necessarey to
> test this out?

You should be able to run it on any SMP machine assuming you write the
arch specific code (PPC could be used as an example). Of course it isn't
very interesting if the hardware doesn't support hot swap :)

As soon as I get the SMP ultra booting again (I arrived one morning to
hear the disk was making loud grinding noises) I'll code up sparc (ie E10K)
support. It sounds like S390 support will be trivial, I'd love to get my
hands on one of those :)

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
