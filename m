Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263784AbTCVTyO>; Sat, 22 Mar 2003 14:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263786AbTCVTyO>; Sat, 22 Mar 2003 14:54:14 -0500
Received: from verdi.et.tudelft.nl ([130.161.38.158]:65408 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S263784AbTCVTyN>; Sat, 22 Mar 2003 14:54:13 -0500
Message-Id: <200303222005.h2MK5D004881@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: linux-kernel
To: Doug McNaught <doug@mcnaught.org>
Cc: robn@verdi.et.tudelft.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.4 has O_SYNC bug ? 
In-Reply-To: Your message of "22 Mar 2003 14:37:53 EST."
             <m37kar42ge.fsf@varsoon.wireboard.com> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Sat, 22 Mar 2003 21:05:13 +0100
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Rob van Nieuwkerk <robn@verdi.et.tudelft.nl> writes:
> 
> > But the strange thing is this:  always after 30s the kernel performs
> > extra writes to the CF.  It seems it's flushing some kind of dirty buffer
> > from the buffer cache.  But there is not supposed to be any dirty buffer:
> > all data should have been written already to the CF because the partition
> > was opened with O_SYNC !
> 
> noatime?

For what ?
As you can read in my posting there is no file-system for the data
area, just a raw partition.  And the root-fs is mounted read-only
(and not even active btw) ..

	Rob van Nieuwkerk
