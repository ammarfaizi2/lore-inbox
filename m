Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315009AbSD2KKQ>; Mon, 29 Apr 2002 06:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315004AbSD2KKP>; Mon, 29 Apr 2002 06:10:15 -0400
Received: from gandalf.axion.bt.co.uk ([132.146.17.29]:11240 "EHLO
	gandalf.axion.bt.co.uk") by vger.kernel.org with ESMTP
	id <S314998AbSD2KKO>; Mon, 29 Apr 2002 06:10:14 -0400
Message-ID: <F66469FCE9C5D311B8FF0000F8FE9E070965D2A9@mbtlipnt03.btlabs.bt.co.uk>
From: chris.2.dobbs@bt.com
To: harada@mbr.sphere.ne.jp, lists@ronpagani.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.5.9,2.5.10 kernel compile, +SMP?
Date: Mon, 29 Apr 2002 11:08:42 +0100
X-Mailer: Internet Mail Service (5.5.2654.89)
MIME-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Try clearing out include/linux/modules/* , before u run
make menuconfig.
If u have prev. compiled for SMP support seems to not clean up
properly.

-----Original Message-----
From: Bruce Harada
To: Ron Pagani / San Francisco / San Jose, CA
Cc: linux-kernel@vger.kernel.org
Sent: 4/28/02 9:26 AM
Subject: Re: 2.5.9,2.5.10 kernel compile, +SMP?

On Sat, 27 Apr 2002 23:55:41 -0700
"Ron Pagani / San Francisco / San Jose, CA" <lists@ronpagani.com> wrote:

> Folks:
> 
> Compile config question...
> 
> Single processor machine (Pentium III)
> 
> SMP comes default "ON" in my 2.5.10 and 2.5.9 config; why is it that
if 
> I turn it off (since I'm only using one processor) the build breaks?
I 
> can post the part it chokes on (I recall something regarding 
> cpu_number)...
> 
> I this a broken config issue, or is someone/thing have a SMP
dependency 
> in the 2.5 series?

make mrproper
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
