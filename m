Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131420AbRBQUcg>; Sat, 17 Feb 2001 15:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131982AbRBQUc0>; Sat, 17 Feb 2001 15:32:26 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26376 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131420AbRBQUcN>; Sat, 17 Feb 2001 15:32:13 -0500
Subject: Re: Is this the ultimate stack-smash fix?
To: Florian.Weimer@RUS.Uni-Stuttgart.DE (Florian Weimer)
Date: Sat, 17 Feb 2001 20:32:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <tgvgq9mvrb.fsf@mercury.rus.uni-stuttgart.de> from "Florian Weimer" at Feb 17, 2001 11:47:20 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14UE2E-00071p-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> need fat pointers, which would make sizeof (long) /= sizeof (void *),
> which would break quite some software, I think.

There are plenty of architectures where sizeof long != sizeof (void *). If your
code makes bad assumptions and a bounds checking cc breaks it then its progress.

