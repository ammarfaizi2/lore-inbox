Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLWJeA>; Sat, 23 Dec 2000 04:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbQLWJdu>; Sat, 23 Dec 2000 04:33:50 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:13067 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129183AbQLWJdh>; Sat, 23 Dec 2000 04:33:37 -0500
Message-ID: <3A446A49.C1E7AAFB@Hell.WH8.TU-Dresden.De>
Date: Sat, 23 Dec 2000 10:03:05 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre4 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: New discoveries in the EEPro100 init saga
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

After enabling the option "EEPRO100_PM" and upgrading to test13-pre4
my problems with the eepro100 driver mysteriously ceased to exist.
I no longer see any "Card reports no RX buffers" or "Card reports no
resources" messages.

Since I don't think -pre4 changed anything from -pre3 that would
affect the eepro100 driver, my bet is that enabling the experimental
power management feature somehow works around the issue.

Can others who've had similar problems check if that works for them
as well? If it does, it should be somewhat simple to work out what
the problem actually is, because the PM code is just a couple dozen
lines.

Merry X-mas!

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
