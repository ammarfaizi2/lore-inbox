Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132545AbRDHMMH>; Sun, 8 Apr 2001 08:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132546AbRDHML5>; Sun, 8 Apr 2001 08:11:57 -0400
Received: from office.mandrakesoft.com ([195.68.114.34]:58106 "HELO
	giants.mandrakesoft.com") by vger.kernel.org with SMTP
	id <S132545AbRDHMLr>; Sun, 8 Apr 2001 08:11:47 -0400
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible bug for Kernel 2.4.3 -> make modules_install
In-Reply-To: <3ACFA8DB.A0A21AB7@boosthardware.com>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 08 Apr 2001 15:10:55 +0200
In-Reply-To: <3ACFA8DB.A0A21AB7@boosthardware.com>
Message-ID: <m37l0vfsf4.fsf@giants.mandrakesoft.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Shirkey <pshirkey@boosthardware.com> writes:

> I am having trouble installing modules. The command hangs at the
> following point in the install...
> 
> -------------------
>   Finished dependencies of target file `_modinst_post'.
>   Must remake target `_modinst_post'.
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.3; fi
> Putting child 0x08088a88 PID 01056 on the chain.
> Live child 0x08088a88 PID 1056
> /sbin/depmod: invalid option -- F
> Usage: depmod [-e -s -v ] -a [FORCED_KERNEL_VER]
>        depmod [-e -s -v ] MODULE_1.o MODULE_2.o ...
> Create module-dependency information for modprobe.

(chmou@no)[linux/Documentation]-% grep modutils Changes 
o  modutils               2.4.2                   # insmod -V
Upgrade to recent modutils to fix various outstanding bugs which are
requires that you upgrade to a recent modutils.
o  <ftp://ftp.kernel.org/pub/linux/utils/kernel/modutils/v2.4/>


-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
