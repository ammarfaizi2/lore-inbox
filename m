Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267596AbSLNLFi>; Sat, 14 Dec 2002 06:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267598AbSLNLFh>; Sat, 14 Dec 2002 06:05:37 -0500
Received: from ulima.unil.ch ([130.223.144.143]:28591 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S267596AbSLNLFh>;
	Sat, 14 Dec 2002 06:05:37 -0500
Date: Sat, 14 Dec 2002 12:13:24 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Not able to compile modutils-2.4.21-7.src.rpm
Message-ID: <20021214111324.GA22498@ulima.unil.ch>
References: <20021214000944.30118.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021214000944.30118.qmail@linuxmail.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2002 at 08:09:43AM +0800, Paolo Ciarrocchi wrote:
> Hi Rusty and Adam,
> I send you again this bug report.
> 
> [root@frodo module-init-tools-0.9.3]# rpm --rebuild /mnt/nt/linux/kernel/modules/modutils-2.4.21-7.src.rpm
> 
> gcc -O3 -fomit-frame-pointer -pipe -mcpu=pentiumpro -march=i586 -ffast-math -fno-strength-reduce -o modinfo modinfo.o ../obj/libobj.a ../util/libutil.a
> gcc -static -O3 -fomit-frame-pointer -pipe -mcpu=pentiumpro -march=i586 -ffast-math -fno-strength-reduce -o insmod.static insmod.o rmmod.o modprobe.o lsmod.o ksyms.o kallsyms.o ../obj/libobj.a ../util/libutil.a
> /usr/bin/ld: cannot find -lc
> collect2: ld returned 1 exit status
> make[1]: *** [insmod.static] Error 1

Just install glibc-static-devel...

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
