Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264451AbRFPQs5>; Sat, 16 Jun 2001 12:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264441AbRFPQsr>; Sat, 16 Jun 2001 12:48:47 -0400
Received: from femail14.sdc1.sfba.home.com ([24.0.95.141]:57472 "EHLO
	femail14.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S264416AbRFPQsg>; Sat, 16 Jun 2001 12:48:36 -0400
Date: Sat, 16 Jun 2001 12:48:05 -0400
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac15
Message-ID: <20010616124805.A4416@zero>
In-Reply-To: <20010615230635.A27708@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010615230635.A27708@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Fri, Jun 15, 2001 at 11:06:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mach_kbd_rate was changed to kbd_rate, but not defined.

vt.c: In function `vt_ioctl':
vt.c:504: `kbd_rate' undeclared (first use in this function)
vt.c:504: (Each undeclared identifier is reported only once
vt.c:504: for each function it appears in.)
vt.c:510: `kbd_rate' used prior to declaration
vt.c:510: warning: implicit declaration of function `kbd_rate'
make[3]: *** [vt.o] Error 1
make[2]: *** [first_rule] Error 2
make[1]: *** [_subdir_char] Error 2
make: *** [_dir_drivers] Error 2

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
