Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276397AbRJKOR4>; Thu, 11 Oct 2001 10:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276411AbRJKORq>; Thu, 11 Oct 2001 10:17:46 -0400
Received: from linux.kappa.ro ([194.102.255.131]:26340 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S276397AbRJKORk>;
	Thu, 11 Oct 2001 10:17:40 -0400
Date: Thu, 11 Oct 2001 17:17:37 +0300
From: Mircea Damian <Mircea.Damian@astral.kappa.ro>
To: war <war@starband.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AIC7XXX Question
Message-ID: <20011011171737.H14161@linux.kappa.ro>
In-Reply-To: <3BC3B110.1801FBAD@starband.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BC3B110.1801FBAD@starband.net>; from war@starband.net on Tue, Oct 09, 2001 at 10:23:12PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You need to include linux/module.h to get the definition.

On Tue, Oct 09, 2001 at 10:23:12PM -0400, war wrote:
> What exactly (besides commenting out that line) do I need to do to fix
> this problem?
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.11/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686    -c -o aic7xxx_old.o aic7xxx_old.c
> aic7xxx_old.c:11966: parse error before string constant
> aic7xxx_old.c:11966: warning: type defaults to `int' in declaration of
> `MODULE_LICENSE'
> aic7xxx_old.c:11966: warning: function declaration isn't a prototype
> aic7xxx_old.c:11966: warning: data definition has no type or storage
> class
> make[3]: *** [aic7xxx_old.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.4.11/drivers/scsi'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.4.11/drivers/scsi'
> make[1]: *** [_subdir_scsi] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.11/drivers'
> make: *** [_dir_drivers] Error 2
> [root@war linux]#
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Mircea Damian
E-mails: dmircea@kappa.ro, dmircea@roedu.net
WebPage: http://taz.mania.k.ro/~dmircea/
