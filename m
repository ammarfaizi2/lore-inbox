Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130290AbQK3GYd>; Thu, 30 Nov 2000 01:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130376AbQK3GYW>; Thu, 30 Nov 2000 01:24:22 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:26605 "EHLO
        smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
        id <S130290AbQK3GYP>; Thu, 30 Nov 2000 01:24:15 -0500
Message-ID: <3A25EB64.3462AE4D@haque.net>
Date: Thu, 30 Nov 2000 00:53:40 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Keyspan USB PDA adapter && test12pre3 hang
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone else out there with a Keyspan USB PDA adapter using test12-pre3?
I'm experiencing hangs when I try to send data to my Palm Vx using it.
Locks up the machine hard. No SysRq. No messages. USB serial debug
output doesn't have much either...

Nov 30 00:09:25 viper kernel: keyspan_pda.c: keyspan_pda_write(16) 
Nov 30 00:09:25 viper kernel: usbserial.c: serial_write - port 0, 43
byte(s) 
Nov 30 00:09:25 viper kernel: keyspan_pda.c: keyspan_pda_write(43) 
Nov 30 00:09:25 viper kernel: usbserial.c: serial_write - port 0, 43
byte(s) 
Nov 30 00:09:25 viper kernel: keyspan_pda.c: keyspan_pda_write(43) 

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
