Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130682AbRBLA2N>; Sun, 11 Feb 2001 19:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130766AbRBLA2C>; Sun, 11 Feb 2001 19:28:02 -0500
Received: from [212.117.90.2] ([212.117.90.2]:2567 "EHLO anduin.gondor.com")
	by vger.kernel.org with ESMTP id <S130682AbRBLA15>;
	Sun, 11 Feb 2001 19:27:57 -0500
Date: Mon, 12 Feb 2001 01:27:55 +0100
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: /dev/rtc not working on ASUS A7V133
Message-ID: <20010212012755.A656@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If my ASUS A7V133-based computer got started by the bios automatic
startup timer, /dev/rtc doesn't work properly. /proc/drivers/rtc
shows sane values, but IRQ 8 is not triggered causing programms like
'hwclock' to hang.

I assume this is not a kernel bug but a BIOS problem, but it would be
nice if a kernel workaround was possible. Does anybody have an 
idea what I could try to reenable the interrupts?

Jan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
