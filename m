Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263128AbSJBQKQ>; Wed, 2 Oct 2002 12:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263129AbSJBQKQ>; Wed, 2 Oct 2002 12:10:16 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:33485 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S263128AbSJBQKP>; Wed, 2 Oct 2002 12:10:15 -0400
Date: Wed, 2 Oct 2002 16:35:28 +0100
From: Stig Brautaset <stig@brautaset.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40: unresolved symbols in apm.o
Message-ID: <20021002153528.GA11109@arwen.brautaset.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Location: London, UK
X-URL: http://brautaset.org
X-KeyServer: wwwkeys.nl.pgp.net
X-PGP/GnuPG-Key: 9336ADC1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to compile apm as a module, I get this error when I do 
"make modules_install":

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.40; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.40/kernel/arch/i386/kernel/apm.o
depmod:         cpu_gdt_table
make: *** [_modinst_post] Error 1

If I chose to compile apm directly into the kernel, there's no problems.
Please let me know if I should post the .config where the error occurs.


Stig
-- 
brautaset.org
