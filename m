Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275086AbRJJIX5>; Wed, 10 Oct 2001 04:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275087AbRJJIXr>; Wed, 10 Oct 2001 04:23:47 -0400
Received: from 157-151.nwinfo.net ([216.187.157.151]:26754 "EHLO
	mail.morcant.org") by vger.kernel.org with ESMTP id <S275086AbRJJIXg>;
	Wed, 10 Oct 2001 04:23:36 -0400
Message-ID: <32924.24.255.76.12.1002702247.squirrel@webmail.morcant.org>
Date: Wed, 10 Oct 2001 01:24:07 -0700 (PDT)
Subject: Re: Tainted Modules Help Notices
From: "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>
To: dwmw2@infradead.org
In-Reply-To: <3869.1002702058@redhat.com>
In-Reply-To: <3869.1002702058@redhat.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
>sirmorcant@morcant.org said:
>>     After compiling 2.4.11 I noticed modprobe picking up some of the
>> tainted modules that were marked in the update.
> 
>>     What surprised me was the PPP compression modules, I didn't use
>> PPP in 2.4.10 so maybe the notice was there in 2.4.10, but I didn't use them so I
>> didn't see it. I shouldn't have been surprised, but I was. BSD compression, BSD
>> license... doh... :> 
> 
> BSD-licensed modules shouldn't mark the kernel as tainted. If they do,  that's surely
> a bug.
> 
> Any code which is distributed as part of the kernel source tree has a  sane, if not
> 100% compatible, licence and shouldn't taint your kernel.
> 
> --
> dwmw2

fs/nls/nls_cp737.c:MODULE_LICENSE("BSD without advertising clause");

Warning: loading /lib/modules/2.4.11/kernel/fs/nls/nls_cp737.o will taint the kernel:
non-GPL license - BSD without advertising clause

# cat /proc/sys/kernel/tainted 
1



-- 
Morgan Collins [Ax0n] http://sirmorcant.morcant.org
Software is something like a machine, and something like mathematics, and something like
language, and something like thought, and art, and information.... but software is not in
fact any of those other things.

