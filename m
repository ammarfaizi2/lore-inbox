Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275963AbRI1Hrp>; Fri, 28 Sep 2001 03:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275966AbRI1Hre>; Fri, 28 Sep 2001 03:47:34 -0400
Received: from chiara.elte.hu ([157.181.150.200]:43278 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S275963AbRI1HrX>;
	Fri, 28 Sep 2001 03:47:23 -0400
Date: Fri, 28 Sep 2001 09:45:25 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Albert Cranford <ac9410@bellsouth.net>
Cc: Andrew Morton <akpm@zip.com.au>, <ookhoi@dds.nl>,
        <linux-kernel@vger.kernel.org>
Subject: [patch] netconsole-2.4.10-C2
In-Reply-To: <3BB3E647.F2B33A41@bellsouth.net>
Message-ID: <Pine.LNX.4.33.0109280939090.1569-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Sep 2001, Albert Cranford wrote:

> Great tool Ingo thanks.  Below is a tested tulip patch.
> Thanks Andrew for the the inspiration.

thanks Albert - i've added it to the patch, and the latest
netconsole-2.4.10-C2 version can be downloaded from:

	http://redhat.com/~mingo/netconsole-patches/

NOTE: new client-side utilities are needed as well.

other changes:

 - netconsole-server fix from Andreas Dilger

 - introduced versioning and offsetting of output, to display messages in
   the correct order even if interim routers reorder packets. Future
   netconsole-clients should reliably detect the right protocol version.

 - small cleanups.

	Ingo

