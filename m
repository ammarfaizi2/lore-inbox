Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129208AbQKUJXh>; Tue, 21 Nov 2000 04:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129960AbQKUJX1>; Tue, 21 Nov 2000 04:23:27 -0500
Received: from nas1-203.kmp.club-internet.fr ([213.44.17.203]:42738 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S129208AbQKUJXR>;
	Tue, 21 Nov 2000 04:23:17 -0500
Message-Id: <200011210849.JAA08318@microsoft.com>
Subject: BUG: 2.2.17 and APM
From: Xavier Bestel <xavier.bestel@free.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution 0.6 (Developer Preview)
Date: 21 Nov 2000 07:49:03 -0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it seems that since I have 2.2.17, APM events aren't processed as they
should: sometimes my laptop just halts instead of sleeping/hibernating.
This often (but not always) occurs when:
* I push the on/off button (which should only go to standby)
* The battery is low
* The timeout for entering standby when on battery power happens
* The timeout for entering hibernate when in standby mode happens
* I hit Fn-on/off (which should go to hibernate)
It never happened when I was using 2.2.16
It never happens when I type "apm -s" or "apm -S" (which do exactely the
same)
I didn't change BIOS settings since 2.2.16

I have a Compaq Armada 1700 with BIOS dated 06/04/99

That's quite annoying. Anyone has this sort of problem ?

Xav

PS: of course, no oops or serious bug report ...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
