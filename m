Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314490AbSDRXIv>; Thu, 18 Apr 2002 19:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314491AbSDRXIu>; Thu, 18 Apr 2002 19:08:50 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:2260 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S314490AbSDRXIs>;
	Thu, 18 Apr 2002 19:08:48 -0400
Message-ID: <3CBF5183.B87E1238@hp.com>
Date: Thu, 18 Apr 2002 17:06:43 -0600
From: Khalid Aziz <khalid_aziz@hp.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: COM1 became ttyS01 in 2.4.19-pre7
In-Reply-To: <Pine.LNX.4.44.0204181855430.21502-100000@marabou.research.att.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Look for a patch already posted to LKML on Tuesday under thread "Linux
2.4.19-pre7".

--
Khalid

Pavel Roskin wrote:
> 
> Hello!
> 
> The serial ports have changed their names after upgrading from 2.4.19-pre4
> to 2.4.19-pre7.  What used to be /dev/ttyS0 is /dev/ttyS1 now.
> 
> This is from the kernel log:
> 
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI enabled
> ttyS01 at 0x03f8 (irq = 4) is a 16550A
> ttyS02 at 0x02f8 (irq = 3) is a 16550A
> 
> $ ls -l /dev/tts/
> total 0
> crw-rw-rw-    1 root     root       4,  65 Apr 18 18:50 1
> crw-rw-rw-    1 root     root       4,  66 Dec 31  1969 2
> 
> I'm using AMD K7, SMP is disabled, serial ports are enabled, ACPI is
> disabled, APM is enabled, devfs is enabled and used, CONFIG_SERIAL_CONSOLE
> is enabled but not currently used.  The motherboard is AOpen KT-133.  The
> ports are set in BIOS to standard COM1 and COM2 settings.
> 
> I'm ready to provide more information if needed.
> 
> --
> Regards,
> Pavel Roskin
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

====================================================================
Khalid Aziz                              Linux Systems Operation R&D
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
