Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131939AbRAERYJ>; Fri, 5 Jan 2001 12:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131830AbRAERX7>; Fri, 5 Jan 2001 12:23:59 -0500
Received: from [156.46.206.66] ([156.46.206.66]:3089 "EHLO eagle.netwrx1.com")
	by vger.kernel.org with ESMTP id <S131504AbRAERXm>;
	Fri, 5 Jan 2001 12:23:42 -0500
From: "George R. Kasica" <georgek@netwrx1.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 Module compile error
Date: Fri, 05 Jan 2001 11:23:29 -0600
Organization: Netwrx Consulting Inc.
Reply-To: georgek@netwrx1.com
Message-ID: <ek0c5t404dfib22jc6je0dldkj57e07k7d@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile in the LM Sensors stuff here and a make
modules_install fails as follows:

>make[1]: Nothing to be done for `modules_install'.
>make[1]: Leaving directory `/usr/src/linux-2.4.0/arch/i386/lib'
>cd /lib/modules/2.4.0; \
>mkdir -p pcmcia; \
>find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
>pcmcia
>if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.0; fi
>depmod: /lib/modules//2.2.18/modules.dep is not an ELF file
>depmod: error reading ELF header
>/lib/modules//2.2.18/modules.generic_string: No
> such file or directory
>depmod: /lib/modules//2.2.18/modules.isapnpmap is not an ELF file
>depmod: error reading ELF header /lib/modules//2.2.18/modules.parportmap:
>No suc
>h file or directory
>depmod: /lib/modules//2.2.18/modules.pcimap is not an ELF file
>depmod: /lib/modules//2.2.18/modules.usbmap is not an ELF file
>depmod: *** Unresolved symbols in /lib/modules//2.2.18/misc/i2c-ali1535.o
>depmod:         release_region_R43bde9b1
>depmod:         request_region_R6d32b2d7
>depmod:         check_region_R522f4d72
>depmod: *** Unresolved symbols in /lib/modules//2.2.18/misc/i2c-ali15x3.o
>depmod:         release_region_R43bde9b1
>depmod:         request_region_R6d32b2d7
>depmod:         check_region_R522f4d72
>depmod: *** Unresolved symbols in /lib/modules//2.2.18/misc/i2c-amd756.o
>depmod:         release_region_R43bde9b1
>depmod:         request_region_R6d32b2d7
>depmod:         check_region_R522f4d72
>depmod: *** Unresolved symbols in /lib/modules//2.2.18/misc/i2c-elektor.o
>depmod:         release_region_R43bde9b1
>depmod:         request_region_R6d32b2d7
>depmod:         check_region_R522f4d72
>depmod: *** Unresolved symbols in /lib/modules//2.2.18/misc/i2c-elv.o
>depmod:         release_region_R43bde9b1
>depmod:         request_region_R6d32b2d7
>depmod:         check_region_R522f4d72
>depmod: *** Unresolved symbols in /lib/modules//2.2.18/misc/i2c-i801.o
>depmod:         release_region_R43bde9b1
>depmod:         request_region_R6d32b2d7
>depmod:         check_region_R522f4d72
>depmod: *** Unresolved symbols in /lib/modules//2.2.18/misc/i2c-piix4.o
>depmod:         release_region_R43bde9b1
>depmod:         request_region_R6d32b2d7
>depmod:         check_region_R522f4d72
>depmod: *** Unresolved symbols in /lib/modules//2.2.18/misc/i2c-sis5595.o
>depmod:         release_region_R43bde9b1
>depmod:         request_region_R6d32b2d7
>depmod:         check_region_R522f4d72
>depmod: *** Unresolved symbols in /lib/modules//2.2.18/misc/i2c-velleman.o
>depmod:         release_region_R43bde9b1
>depmod:         request_region_R6d32b2d7
>depmod:         check_region_R522f4d72
>depmod: *** Unresolved symbols in /lib/modules//2.2.18/misc/i2c-via.o
>depmod:         release_region_R43bde9b1
>depmod:         request_region_R6d32b2d7
>depmod:         check_region_R522f4d72
>depmod: *** Unresolved symbols in /lib/modules//2.2.18/misc/i2c-viapro.o
>depmod:         release_region_R43bde9b1
>depmod:         request_region_R6d32b2d7
>depmod:         check_region_R522f4d72
>depmod: *** Unresolved symbols in /lib/modules//2.2.18/misc/lm78.o
>depmod:         release_region_R43bde9b1
>depmod:         request_region_R6d32b2d7
>depmod:         check_region_R522f4d72
>depmod: *** Unresolved symbols in /lib/modules//2.2.18/misc/sensors.o
>depmod:         check_region_R522f4d72
>depmod: *** Unresolved symbols in /lib/modules//2.2.18/misc/sis5595.o
>depmod:         release_region_R43bde9b1
>depmod:         request_region_R6d32b2d7
>depmod:         check_region_R522f4d72
>depmod: *** Unresolved symbols in /lib/modules//2.2.18/misc/via686a.o
>depmod:         release_region_R43bde9b1
>depmod:         request_region_R6d32b2d7
>depmod:         check_region_R522f4d72
>depmod: *** Unresolved symbols in /lib/modules//2.2.18/misc/w83781d.o
>depmod:         release_region_R43bde9b1
>depmod:         request_region_R6d32b2d7
>depmod:         check_region_R522f4d72

make bzImage and make modules is just fine....

Any thoughts or a way to fix or should I not include these in my
kernel?

Please CC me directly as the DNS changes due to my ISP renumbering us
here are still wacked out....

George

George, MR. Tibbs & The Beast Kasica
Waukesha, WI USA
georgek@netwrx1.com
http://www.netwrx1.com
ICQ #12862186

      Zz
       zZ
    |\ z    _,,,---,,_
    /,`.-'`'    _   ;-;;,_
   |,4-  ) )-,_..;\ (  `'_'
  '---''(_/--'  `-'\_)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
