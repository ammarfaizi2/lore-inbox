Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263481AbTJLRKh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 13:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTJLRKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 13:10:36 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:25861 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263481AbTJLRKf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 13:10:35 -0400
To: Ludovico Gardenghi <garden@despammed.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vfat corruption in 2.6.0?
References: <20031012095720.GA21405@ripieno.somiere.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 13 Oct 2003 02:10:09 +0900
In-Reply-To: <20031012095720.GA21405@ripieno.somiere.org>
Message-ID: <87pth2jsb2.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ludovico Gardenghi <garden@despammed.com> writes:

> He has a quite big vfat partition (60 GB) created with mkfs.vfat; he
> ran a program that had to write ~5000 files summing up to 18 GB but
> some hour after that program started (it's a simulation tool that
> runs for ~20 hours on an athlon XP 2500+) his /var started to fill with
> log errors of "attempt to access beyond the end of the device".
> The files are very fragmented because they are written line by line
> more or less in parallel.
> 
> Moreover, the partition resulted unmountable and fsck.vfat could not
> manage to repair it --- the only solution being running MS win's
> scandisk tool. After the repair some of the smaller files on the disk
> got lost and some part of the bigger files got corrupted.
> 
> This happened twice (with test3 and test6) and the partition was
> completely erased and re-created between the 2 crashes.
> 
> I can't tell much more than this because my friend had to erase his logs
> because they filled up /var.
> 
> Ludovico
> -- 
> <dunadan@libero.it>          #acheronte (irc.freenode.net) ICQ: 64483080
> GPG ID: 07F89BB8              Jabber: garden@jabber.students.cs.unibo.it
> -- This is signature nr. 1249
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
