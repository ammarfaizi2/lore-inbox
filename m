Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbUJZR5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUJZR5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUJZR45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:56:57 -0400
Received: from zamok.crans.org ([138.231.136.6]:1768 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261377AbUJZRyt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:54:49 -0400
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1: LVM stopped working
References: <87oeitdogw.fsf@barad-dur.crans.org>
	<58cb370e041026070067daa404@mail.gmail.com>
	<58cb370e0410261007145fc22c@mail.gmail.com>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Tue, 26 Oct 2004 19:54:47 +0200
In-Reply-To: <58cb370e0410261007145fc22c@mail.gmail.com> (Bartlomiej
	Zolnierkiewicz's message of "Tue, 26 Oct 2004 19:07:45 +0200")
Message-ID: <87oeipcql4.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> disait dernièrement que :


>> > However, I use dm-crypt to encrypt my / (no initrd, just initramfs) and
>> > it works under 2.6.9-mm1, so the bug is likely to be in IDE stuff.
>> 
>> prove it ;)
>
> To make this task easier I prepared 2.6.9-rc3-mm3 to 2.6.9-mm1 IDE patch:
>
> http://home.elka.pw.edu.pl/~bzolnier/ide-2.6.9-rc3-mm3-to-2.6.9-mm1.patch.bz2
>
> Just revert it from 2.6.9-mm1.

reverting ide changes do not change anything....
error is still here
The only changes I can see now, are the md changes. I will try reverting it,
and if I get no positive results, I give up (for today :))

-- 
printk("What? oldfid != cii->c_fid. Call 911.\n");
        linux-2.4.3/fs/coda/cnode.c

