Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbSKCXKv>; Sun, 3 Nov 2002 18:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263320AbSKCXKv>; Sun, 3 Nov 2002 18:10:51 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:51212 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263313AbSKCXKu>; Sun, 3 Nov 2002 18:10:50 -0500
From: Han-Wen Nienhuys <hanwen@cs.uu.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15813.44941.592105.853906@blauw.xs4all.nl>
Date: Mon, 4 Nov 2002 00:21:49 +0100
To: James Stevenson <james-lists@stev.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Help!] 2.4.20 IDE-SCSI / CD-writing crash
In-Reply-To: <1036365120.1540.11.camel@god.stev.org>
References: <3DC59E5B.2040007@yahoo.com>
	<200211032253.gA3Mrw1B008818@smtpzilla1.xs4all.nl>
	<1036365120.1540.11.camel@god.stev.org>
X-Mailer: VM 7.05 under Emacs 21.2.1
Reply-To: hanwen@cs.uu.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

james-lists@stev.org writes:
> yeah this happens to me under certin combinations of hardware
> eg dont put a cd write on the same channel as a disk or
> you seem to run into problems.

The writer is on 2nd IDE channel (hdd), the HD is on  the 1st (hda).

> you saw 2.4.20 ? i dont think that kernel is out yet.

20-rc1

FWIW, I also tried disabling DMA on the cdrom drive; no-go:   at the
3rd burn, the ATAPI resets were all over the place.

-- 

Han-Wen Nienhuys   |   hanwen@cs.uu.nl   |   http://www.cs.uu.nl/~hanwen 
