Return-Path: <linux-kernel-owner+w=401wt.eu-S1760466AbWLILtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760466AbWLILtc (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 06:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760731AbWLILtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 06:49:32 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48566 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760466AbWLILtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 06:49:31 -0500
Date: Sat, 9 Dec 2006 12:49:30 +0100
From: Jan Kara <jack@suse.cz>
To: Jim van Wel <jim@coolzero.info>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Ext3 Errors...
Message-ID: <20061209114930.GE10261@atrey.karlin.mff.cuni.cz>
References: <13634.62.194.65.8.1165659510.squirrel@webmail.coolzero.info> <20061209105436.GB10261@atrey.karlin.mff.cuni.cz> <16096.62.194.65.8.1165661845.squirrel@webmail.coolzero.info> <20061209113406.GC10261@atrey.karlin.mff.cuni.cz> <19683.62.194.65.8.1165664691.squirrel@webmail.coolzero.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19683.62.194.65.8.1165664691.squirrel@webmail.coolzero.info>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> Well, that's kind of difficult because it looks a little random when he
> does it, and a interval of three days, but also is maybe random.
> 
> And the most difficult part is it's only for three seconds, and than it's
> gone, so making a crontab script every minute might not even notice it?
  Oh, so the machine does not crash or go totally out of memory when this
happens? At least it seems the filesystem is remounted RO?

<snip>
> >> >> Dec  5 23:50:49 kernel: do_get_write_access: OOM for frozen_buffer
> >> >> Dec  5 23:50:49 kernel: ext3_free_blocks_sb: aborting transaction:
> >> Out
> >> >> of
> >> >> memory in __ext3_journal_get_undo_access
> >> >> Dec  5 23:50:49 kernel: EXT3-fs error (device md1) in
> >> >> ext3_free_blocks_sb:
> >> >> Out of memory
> >> >> Dec  5 23:50:49 kernel: EXT3-fs error (device md1) in
> >> >> ext3_reserve_inode_write: Readonly filesystem
> >> >> Dec  5 23:50:50 kernel: EXT3-fs error (device md1) in ext3_truncate:
> >> Out
> >> >> of memory
> >> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
> >> >> ext3_reserve_inode_write: Readonly filesystem
> >> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
> >> ext3_orphan_del:
> >> >> Readonly filesystem
> >> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
> >> >> ext3_reserve_inode_write: Readonly filesystem
> >> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
> >> ext3_delete_inode:
> >> >> Out of memory
 <snip>

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
