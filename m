Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132375AbQKZRAM>; Sun, 26 Nov 2000 12:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132436AbQKZRAC>; Sun, 26 Nov 2000 12:00:02 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:40645 "EHLO
        smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
        id <S132375AbQKZQ7n>; Sun, 26 Nov 2000 11:59:43 -0500
To: buhr@stat.wisc.edu (Kevin Buhr)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test5 bug: invalid "shmid_kernel" passed to "shm_nopage_core"
In-Reply-To: <vbaaeapf4ti.fsf@mozart.stat.wisc.edu>
        <m3g0kggydi.fsf@linux.local> <vbay9y7dxgr.fsf@mozart.stat.wisc.edu>
From: Christoph Rohland <cr@sap.com>
Date: 26 Nov 2000 11:41:21 +0100
In-Reply-To: buhr@stat.wisc.edu's message of "26 Nov 2000 01:05:56 -0600"
Message-ID: <m37l5rggmm.fsf@linux.local>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

buhr@stat.wisc.edu (Kevin Buhr) writes:

> I know no way to reproduce it.  I've been using "test5" reliably since
> just after its release, and I've triggered this bug only the one time.

That's what I feared :-(

> I use a SysReq patch to do an oops-style dump instead of the usual
> "showPc" function, so I was able to copy a stack dump down.

Could you send me the patch? Does it do the dump on all cpus?

> I'll fiddle around a bit more and see if I can find a way to reproduce
> it reliably.

I would be happy to help debug the shm code if you find a way to
reproduce it. 

        Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
