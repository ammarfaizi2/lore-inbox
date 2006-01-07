Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWAGBA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWAGBA1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 20:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbWAGBA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 20:00:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:749 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030263AbWAGBA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 20:00:27 -0500
Date: Fri, 6 Jan 2006 17:01:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, arjan@infradead.org,
       nico@cam.org, jes@trained-monkey.org, viro@ftp.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, alan@lxorguk.ukuu.org.uk,
       hch@infradead.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 17/21] mutex subsystem, semaphore to mutex: automatic
 conversion of simpler cases
Message-Id: <20060106170146.7e19a968.akpm@osdl.org>
In-Reply-To: <20060105153903.GR31013@elte.hu>
References: <20060105153903.GR31013@elte.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



2 out of 7 hunks FAILED -- saving rejects to file drivers/md/dm.c.rej
1 out of 4 hunks FAILED -- saving rejects to file drivers/md/md.c.rej
2 out of 20 hunks FAILED -- saving rejects to file drivers/pcmcia/rsrc_nonstatic.c.rej
1 out of 5 hunks FAILED -- saving rejects to file fs/nfs/callback.c.rej
1 out of 10 hunks FAILED -- saving rejects to file security/selinux/selinuxfs.c.rej
2 out of 6 hunks FAILED -- saving rejects to file sound/arm/pxa2xx-ac97.c.rej
6 out of 9 hunks FAILED -- saving rejects to file sound/core/hwdep.c.rej
1 out of 8 hunks FAILED -- saving rejects to file sound/core/info.c.rej
5 out of 13 hunks FAILED -- saving rejects to file sound/core/pcm.c.rej
5 out of 8 hunks FAILED -- saving rejects to file sound/core/rawmidi.c.rej
1 out of 7 hunks FAILED -- saving rejects to file sound/core/seq/oss/seq_oss.c.rej
3 out of 10 hunks FAILED -- saving rejects to file sound/core/seq/seq_device.c.rej
1 out of 8 hunks FAILED -- saving rejects to file sound/core/seq/seq_midi.c.rej
5 out of 8 hunks FAILED -- saving rejects to file sound/core/sound.c.rej
6 out of 8 hunks FAILED -- saving rejects to file sound/core/sound_oss.c.rej
1 out of 22 hunks FAILED -- saving rejects to file sound/core/timer.c.rej
1 out of 6 hunks FAILED -- saving rejects to file sound/usb/usbaudio.c.rej

I think I'll duck this one for now.

Perhaps it should be split up a bit?
