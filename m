Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbTGHWyu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265440AbTGHWyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:54:50 -0400
Received: from devil.servak.biz ([209.124.81.2]:18140 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S265422AbTGHWyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:54:49 -0400
Subject: Re: compactflash cards dying in < hour?
From: Torrey Hoffman <thoffman@arnor.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030708204931.GA602@elf.ucw.cz>
References: <20030708204931.GA602@elf.ucw.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1057700055.3414.71.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Jul 2003 14:34:16 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have some SanDisk CF's here which have withstood at least 20 cycles
of fdisk, mke3fs, and installation of a mini-linux distribution.  They
are all still running ok.  (64 MB mostly, some 128 MB)

They have been accessed through SanDisk USB-to-CF adapters, and also
directly to the IDE channel of Geode-based embedded systems.

Torrey Hoffman
torrey.hoffman@myrio.com (work) - thoffman@arnor.net (home)		

On Tue, 2003-07-08 at 13:49, Pavel Machek wrote:
> Hi!
> 
> I had three diferent CF cards, from two different manufacturers
> (Apacer and Transcend), and both died *really fast*.
> 
> Last one (transcend) died in less than 10 minutes: mke2fs, cat
> /dev/urandom > foo; md5sum foo (few times); cat /dev/urandom > foo and
> I could no longer do cat /dev/urandom because of disk errors.
> 
> I know CompactFlash cards are *crap*, but they should not be *so*
> crappy...?! [I'm testing them from toshiba satellite 4030cdt via
> Apacer PCMCIA-to-CF adapter and in sharp zaurus].
> 
> Are there "known good" 256MB compact flash cards?
> 
> 							Pavel


