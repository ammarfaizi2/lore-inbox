Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129379AbRBUXRo>; Wed, 21 Feb 2001 18:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129738AbRBUXRf>; Wed, 21 Feb 2001 18:17:35 -0500
Received: from m1smtpisp03.wanadoo.es ([62.36.220.63]:5805 "EHLO
	smtp.wanadoo.es") by vger.kernel.org with ESMTP id <S129379AbRBUXRY>;
	Wed, 21 Feb 2001 18:17:24 -0500
Message-ID: <3A944C92.60A1E514@wanadoo.es>
Date: Thu, 22 Feb 2001 00:17:38 +0100
From: Javi Roman <javiroman@wanadoo.es>
X-Mailer: Mozilla 4.75 [es] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mke2fs + 8MB + 2.2.5 = hangs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

Any weeks ago I asked about problem with
program mke2fs. I asked why mke2fs hanged
the system (2.2.5-15) from install program
in a 4 MB machine (with 16 MB swap memory).

Alan Cox answered "its a VM 2.5.5 problem". Well ,I
have increased the RAM memory (up to 8 MB) but I
obtain the same problem: mke2fs hangs the system
with big partitions (no very bigs partitions: 10,
20 MB ...) with 3 MB partiton mke2fs works correctly
(I am using a execl function to run mke2fs).

With 8 MB memory mke2fs uses swap, so I obtain the
same problem?

Really is it a 2.2.5 kernel problem?

With 2.2.14 kernel (for instance) my installation
program would work?

I have not probed a higer kernel because I have any
compiled drivers (I have not sources) for 2.2.5-15 kernel.
I don't know if it's a kernel problem or a install program problem.
(I have a 4MB machine with RedHat 6.2 with 2.2.5-15
kernel and mk2efs work fine with partition over 100MB???)
I don't understand.

Any idea?

