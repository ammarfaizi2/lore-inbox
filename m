Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287958AbSABUxE>; Wed, 2 Jan 2002 15:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287982AbSABUwv>; Wed, 2 Jan 2002 15:52:51 -0500
Received: from svr3.applink.net ([206.50.88.3]:33543 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287957AbSABUtw>;
	Wed, 2 Jan 2002 15:49:52 -0500
Message-Id: <200201022049.g02KndSr022117@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Tony Hoyle <tmh@nothing-on.tv>, timothy.covell@ashavan.org
Subject: Re: system.map
Date: Wed, 2 Jan 2002 14:45:57 -0600
X-Mailer: KMail [version 1.3.2]
Cc: adrian kok <adriankok2000@yahoo.com.hk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com> <200201022006.g02K6vSr021827@svr3.applink.net> <3C336CD0.9060905@nothing-on.tv>
In-Reply-To: <3C336CD0.9060905@nothing-on.tv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 January 2002 14:25, Tony Hoyle wrote:
> Timothy Covell wrote:
> > Not on grub.  I quote:
>
> It works fine on grub.  I use grub.
>
> make install is completely installation agnostic.  It just calls
> /sbin/installkernel with the paths of the various files.  On any sane
> distribution this will work.  If it doesn't it's only a shell script
> with a few symlink & copy commands in it... just write your own.
>
> Tony

So, I guess that RedHat 7.2 must be an insane distribution:

make install
[snip]
System is 1308 kB
warning: kernel is too big for standalone boot from floppy
sh -x ./install.sh 2.4.17 bzImage /home/kernel/linux-2.4.17/System.map ""
+ '[' -x /root/bin/installkernel ']'
+ '[' -x /sbin/installkernel ']'
+ exec /sbin/installkernel 2.4.17 bzImage 
/home/kernel/linux-2.4.17/System.map ''
/etc/lilo.conf: No such file or directory
make[1]: *** [install] Error 1
make[1]: Leaving directory `/home/kernel/linux-2.4.17/arch/i386/boot'
make: *** [install] Error 2


-- 
timothy.covell@ashavan.org.
