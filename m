Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265150AbUASPaa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 10:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265283AbUASPaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 10:30:30 -0500
Received: from thunk.org ([140.239.227.29]:44473 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265150AbUASPa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 10:30:29 -0500
Date: Mon, 19 Jan 2004 10:30:05 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Dittmer <j.dittmer@portrix.net>, linux-kernel@vger.kernel.org
Subject: Re: ext3 on raid5 failure
Message-ID: <20040119153005.GA9261@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jan Dittmer <j.dittmer@portrix.net>, linux-kernel@vger.kernel.org
References: <400A5FAA.5030504@portrix.net> <20040118180232.GD1748@srv-lnx2600.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040118180232.GD1748@srv-lnx2600.matchmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 18, 2004 at 10:02:32AM -0800, Mike Fedyk wrote:
> On Sun, Jan 18, 2004 at 11:27:54AM +0100, Jan Dittmer wrote:
> > EXT3-fs error (device dm-1): ext3_readdir: bad entry in directory 
> > #9783034: rec_len % 4 != 0 - offset=0, inode=1846971784, rec_len=33046, 
> > name_len=154
> > Aborting journal on device dm-1.
> > ext3_abort called.
> > EXT3-fs abort (device dm-1): ext3_journal_start: Detected aborted journal
> > Remounting filesystem read-only
> 
> Run fsck on the filesystem.

Jan, what distribution are you running?  The superblock *should* have
been marked "filesystems has errors", and so fsck should have been
forced when you rebooted.  Did fsck in fact run, and if so, did it
detect and fix any problems?

						- Ted
