Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132383AbQLJEBf>; Sat, 9 Dec 2000 23:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132769AbQLJEBZ>; Sat, 9 Dec 2000 23:01:25 -0500
Received: from smtp1.ihug.co.nz ([203.109.252.7]:59920 "EHLO smtp1.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S132383AbQLJEBS>;
	Sat, 9 Dec 2000 23:01:18 -0500
Message-ID: <3A32F8B9.E6F1FC26@ihug.co.nz>
Date: Sun, 10 Dec 2000 16:30:01 +1300
From: Gerard Sharp <gsharp@ihug.co.nz>
Reply-To: gsharp@ihug.co.nz
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: HPT366 + SMP = slight corruption in 2.3.99 - 2.4.0-11
In-Reply-To: <Pine.LNX.4.10.10012090156060.5191-200000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

> This has the missing ide-pci code from 2.2.
> It stablized my BP6 on the HPT core.

The patch contained a large number of ^M's (about 1 per line), but
applied cleanly after being passed through "sed"

It, however, has NOT corrected the problem :( :(
Corruption still occurs, now under 2.4.0-test12-pre7

> Cheers,
> Andre Hedrick


Good Day and Happy Hacking
Gerard Sharp
Two Penguins at 1024x768
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
