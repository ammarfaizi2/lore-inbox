Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282307AbRKXARJ>; Fri, 23 Nov 2001 19:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282305AbRKXARA>; Fri, 23 Nov 2001 19:17:00 -0500
Received: from dsl-65-186-161-49.telocity.com ([65.186.161.49]:62980 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S282306AbRKXAQi>; Fri, 23 Nov 2001 19:16:38 -0500
Message-Id: <4.3.2.7.2.20011123191428.00db08a0@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 23 Nov 2001 19:16:24 -0500
To: pocm@rnl.ist.utl.pt (Paulo J. Matos aka PDestroy)
From: David Relson <relson@osagesoftware.com>
Subject: Re: Kernel Compilation Basics
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3pu69qheo.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:57 PM 11/23/01, Paulo J. Matos aka PDestroy wrote:
>Hi all,
>
>I'm trying to compile 2.4.15.
>I've read Kernel Howto and I've done the quick compilation steps:
>make xconfig
>make dep
>make clean
>make bzImage
>cp arch/i386/boot/bzImage /boot/vmlinuz-2.4.15
>make modules
>make modules_install
>
>What about now?
>How do I create system map and modules info?
>What are they for?
>I feel that kernel howto is not explicit with this questions.
>Is there any place where can I get insight about these questions?

Rather than "cp ... /boot/..."  use "make install".  If I remember 
correctly, "make install" will even add the proper entry to 
/etc/lilo.conf.  Assuming you are using lilo, you will also need to run it 
after "make modules_install".

David


