Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131154AbQLFUXF>; Wed, 6 Dec 2000 15:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131060AbQLFUWp>; Wed, 6 Dec 2000 15:22:45 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:57102 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S130562AbQLFUWe>; Wed, 6 Dec 2000 15:22:34 -0500
Message-ID: <3A2E98E1.9B9732E4@Hell.WH8.TU-Dresden.De>
Date: Wed, 06 Dec 2000 20:52:01 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Trashing ext2 with hdparm
In-Reply-To: <Pine.LNX.4.10.10012061141300.21407-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andre Hedrick wrote:
> 
> No way that this could cause corruption it is a read-only test.

As others pointed out, it's probably something related to shared
memory, but it's definitely hdparm that triggers it. I haven't
got the hdparm sources here to look at what exactly it's doing,
but there is corruption going on, not on disk, but definitely in
memory.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
