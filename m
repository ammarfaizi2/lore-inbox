Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130405AbRAaGzr>; Wed, 31 Jan 2001 01:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130420AbRAaGz1>; Wed, 31 Jan 2001 01:55:27 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:46096 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130405AbRAaGzW>; Wed, 31 Jan 2001 01:55:22 -0500
Date: Wed, 31 Jan 2001 00:55:19 -0600
To: Bernd Eckenfels <inka-user@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Request: increase in PCI bus limit
Message-ID: <20010131005519.D18746@cadcamlab.org>
In-Reply-To: <E14Nm8S-0001P6-00@sites.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E14Nm8S-0001P6-00@sites.inka.de>; from inka-user@lina.inka.de on Wed, Jan 31, 2001 at 02:32:36AM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Bernd Eckenfels]
> May even decrease the kernel for systems < 4 busses.

Be careful, though.  Users may set this thinking "I have a generic
system with only one PCI bus" without realizing that AGP, cardbus and
some motherboard devices are all counted.  Pad the CONFIG option by
about 4 busses and we'll be OK..

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
