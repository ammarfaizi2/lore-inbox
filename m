Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVHHIbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVHHIbU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 04:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVHHIbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 04:31:20 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:12798 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750761AbVHHIbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 04:31:19 -0400
In-Reply-To: <20050807221218.GD4006@stusta.de>
Subject: Re: [2.6 patch] fix drivers/s390/net/ compilation
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Cornelia Huck <cohuck@de.ibm.com>,
       Frank Pavlic <pavlic@de.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OF2F97FC88.3299C340-ON42257057.002C5606-42257057.002ECD52@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 8 Aug 2005 10:31:12 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 08/08/2005 10:31:17
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote on 08/08/2005 12:12:18 AM:

> Looking at Jan Dittmer's crosscompile site [1], one of the two
> architectures where defconfig compiled in 2.6.12.4 but does no longer
> compile in 2.6.13-rc6 is s390.
>
> Looking at the build error, it seems s390-use-klist-in-qeth-driver.patch
> from -mm was intended to fix this compile error.

That is the correct patch for the qeth compile problem. With the patch
the driver even works ;-)

> I haven't tested whether it is actually enough for getting the s390
> defconfig compiling, but it can't make things worse.

It is enough to get 2.6.13 and qeth working on s390. If you don't need
qeth the current git tree works fine. It's only qeth that doesn't compile.
I've asked Andrew to forward the qeth patch, but seem like they want to
calm things down for 2.6.13.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

