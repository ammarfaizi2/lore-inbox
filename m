Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277387AbRJJT7f>; Wed, 10 Oct 2001 15:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277389AbRJJT7Z>; Wed, 10 Oct 2001 15:59:25 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:51657 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S277387AbRJJT7P>; Wed, 10 Oct 2001 15:59:15 -0400
Subject: Re: APM on a HP Omnibook XE3
Date: 10 Oct 2001 21:59:41 +0200
Organization: Chemnitz University of Technology
Message-ID: <87ofnfb70y.fsf@kosh.ultra.csn.tu-chemnitz.de>
In-Reply-To: <200108301443355.SM00167@there> <m2elobn7a3.fsf@anano.mitica> <m3sncrh9u8.fsf@giants.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
To: linux-kernel@vger.kernel.org
From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chmouel@mandrakesoft.com (Chmouel Boudjnah) writes:

> > robert> I have a HP Omnibook XE3 with SuSE Linux 7.2 installed.
> > robert> Everything works fine except suspend-to-disk.
> > [...]
> > robert> Any ideas what I could do?
> > 
> > For me Fn+F12 works.
> > apm -s & apm -S fails.
> 
> works only if you have a suspend-on-disk partition.

lphdisk can create such a partition for you (or the tool coming on the
HP CD deleting the entire drive).


I have made the experience that hibernation stops to work when GRUB was
installed into the bootsector. When installing it into the MBR all
things are fine and Fn+F12 suspends to disk. (I have heard reports
about a Dell Inspiron 4000, where the opposite situation is the case)

If you have installed the bootloader on hdaX already, you can try to
overwrite the first 512 byte with \0 (yes; it's a dangerous operation).



Enrico

