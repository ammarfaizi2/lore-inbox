Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275178AbRJ2NqM>; Mon, 29 Oct 2001 08:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275398AbRJ2NqD>; Mon, 29 Oct 2001 08:46:03 -0500
Received: from blue.net4u.hr ([195.29.126.3]:23820 "HELO blue.net4u.hr")
	by vger.kernel.org with SMTP id <S275294AbRJ2Npv>;
	Mon, 29 Oct 2001 08:45:51 -0500
Date: Mon, 29 Oct 2001 14:45:08 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.4.13-ac4 compile problem
Message-ID: <20011029144508.A19409@debilian>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Debian GNU/Linux unstable (Linux 2.4.10-ac10)
X-Uptime: 14:35:10 up 3 days, 18:15,  8 users,  load average: 0.40, 0.41, 0.30
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
From: Marko Rebrina <mrebrina@jagor.srce.hr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I got this error:

gcc -D__KERNEL__ -I/usr/src/linux-ac/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4     -c -o quirks.o quirks.c
quirks.c:467: redefinition of quirk_amd_ioapic'
quirks.c:379: quirk_amd_ioapic' previously defined here
{standard input}: Assembler messages:
{standard input}:613: Error: symbol quirk_amd_ioapic' is already defined
make[3]: *** [quirks.o] Error 1
make[3]: Leaving directory /usr/src/linux-ac/drivers/pci'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory /usr/src/linux-ac/drivers/pci'
make[1]: *** [_subdir_pci] Error 2
make[1]: Leaving directory /usr/src/linux-ac/drivers'
make: *** [_dir_drivers] Error 2

-- 
  -o)      // Marko Rebrina, http://jagor.srce.hr/~mrebrina, ICQ:20358351 \\
  /\\  
 _\_v      		http://www.microsoft.com/windowsxp/
