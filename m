Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263428AbTEVXNM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 19:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbTEVXNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 19:13:12 -0400
Received: from ppp-62-245-161-5.mnet-online.de ([62.245.161.5]:1664 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S263428AbTEVXNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 19:13:11 -0400
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.69-mm8] ide_dmaq_intr: stat=40, not expected
From: Julien Oster <lkml@mf.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Fri, 23 May 2003 01:26:14 +0200
In-Reply-To: <20030522225011$5a69@gated-at.bofh.it> (Bartlomiej
 Zolnierkiewicz's message of "Fri, 23 May 2003 00:50:11 +0200")
Message-ID: <frodoid.frodo.87fzn68sx5.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <20030522224010$6dac@gated-at.bofh.it>
	<20030522225011$5a69@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> writes:

> Hello,

Hello Bartlomiej,

> Can you compile without IDE TCQ and tell whats the difference?

Uh, well.

The message disappeared. However, since keyboard and mouse still
didn't work (although all input devices are compiled in - did I miss
something?), I had to press reset again.

Now my system seems quite fucked up. (or, better: "fscked up", since
the problems appeared there...)

After rebooting (again my stable 2.4.21-rc1 kernel), fsck ate a lot of
files on the root partition, all with "unused
inode... CLEARED". Strangely, ONLY on the root filesystem. All other
filesystems (all on md devices, like the root filesystem) are perfect.

I don't know if that's still an issue of IDE TCQ, but I think I'll
quit trying it out, since I already lost X right now and have to
restore quite a few things.

Well, of course I have backups, I wouldn't install a development
kernel without expecting things that are even much worse, but all
those recompile, reboot, retry, reset and restore backup cycles are
currently a bit too time consuming :)

However, if you need additional information to track the TCQ-problem
down, I see what I can give.

Regards,
Julien
