Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289471AbSAJOnO>; Thu, 10 Jan 2002 09:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289472AbSAJOnE>; Thu, 10 Jan 2002 09:43:04 -0500
Received: from [149.168.208.41] ([149.168.208.41]:62727 "EHLO
	ice.dpi.state.nc.us") by vger.kernel.org with ESMTP
	id <S289471AbSAJOnA>; Thu, 10 Jan 2002 09:43:00 -0500
Message-ID: <3C3DA9DC.D00C3C72@hcssystems.com>
Date: Thu, 10 Jan 2002 09:49:00 -0500
From: Josh Wyatt <josh.wyatt@hcssystems.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.19-6.2.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "'Kernel-Mailingliste'" <linux-kernel@vger.kernel.org>
CC: josh.wyatt@hcssystems.com
Subject: Softdog support on non-x86
In-Reply-To: <E16K6eS-0002HR-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I've researched this question and haven't been able to find a suitable
answer.  The answer may be "it's painless as-is, just go for it".  It
might also be "give up now while you still have your pants".

I'd like to use the software watchdog timer, softdog.c, on the Sparc
architecture, using kernel 2.2.17.  I used this to build the module:
cd /usr/src/linux-2.2.17/drivers/char
gcc -c -DMODVERSIONS -D__KERNEL__ -DMODULE -Wall -Wstrict-prototypes
softdog.c

The module builds fine with some warnings.  After copying it over to
/lib/modules/2.2.17/misc/softdog.o and running depmod -a, I get
modprobe: ELF file not for this architecture

I haven't tried modprobe'ing the module yet, the above message frightens
me.

Is this driver safe for the sparc architecture?  If not, what would it
take?  Or did I screw up somwehere along the way?

Please CC: me as I am not on the list.

Thanks in advance,
Josh Wyatt
