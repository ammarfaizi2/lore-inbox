Return-Path: <linux-kernel-owner+w=401wt.eu-S936390AbWLKOzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936390AbWLKOzS (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 09:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936352AbWLKOzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 09:55:18 -0500
Received: from hempcity.net ([81.171.100.190]:52827 "EHLO hempcity.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936390AbWLKOzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 09:55:11 -0500
Message-ID: <29793.84.81.1.164.1165848900.squirrel@webmail.coolzero.info>
In-Reply-To: <20061209114930.GE10261@atrey.karlin.mff.cuni.cz>
References: <13634.62.194.65.8.1165659510.squirrel@webmail.coolzero.info>
    <20061209105436.GB10261@atrey.karlin.mff.cuni.cz>
    <16096.62.194.65.8.1165661845.squirrel@webmail.coolzero.info>
    <20061209113406.GC10261@atrey.karlin.mff.cuni.cz>
    <19683.62.194.65.8.1165664691.squirrel@webmail.coolzero.info>
    <20061209114930.GE10261@atrey.karlin.mff.cuni.cz>
Date: Mon, 11 Dec 2006 15:55:00 +0100 (CET)
Subject: Re: Ext3 Errors...
From: "Jim van Wel" <jim@coolzero.info>
To: "Jan Kara" <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org
Reply-To: jim@coolzero.info
User-Agent: SquirrelMail/1.4.8-2.el4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Well, after I was getting the error again, I now switched back to kernel
2.6.18.1, and going to check if I am getting the same errors. I'll keep
you posted about the progress. If a week have passed and no errors has
shown, I'll e-mail this again.

Thanks!
Jim.

>   Hi,
>
>> Well, that's kind of difficult because it looks a little random when he
>> does it, and a interval of three days, but also is maybe random.
>>
>> And the most difficult part is it's only for three seconds, and than
>> it's
>> gone, so making a crontab script every minute might not even notice it?
>   Oh, so the machine does not crash or go totally out of memory when this
> happens? At least it seems the filesystem is remounted RO?
>
> <snip>
>> >> >> Dec  5 23:50:49 kernel: do_get_write_access: OOM for frozen_buffer
>> >> >> Dec  5 23:50:49 kernel: ext3_free_blocks_sb: aborting transaction:
>> >> Out
>> >> >> of
>> >> >> memory in __ext3_journal_get_undo_access
>> >> >> Dec  5 23:50:49 kernel: EXT3-fs error (device md1) in
>> >> >> ext3_free_blocks_sb:
>> >> >> Out of memory
>> >> >> Dec  5 23:50:49 kernel: EXT3-fs error (device md1) in
>> >> >> ext3_reserve_inode_write: Readonly filesystem
>> >> >> Dec  5 23:50:50 kernel: EXT3-fs error (device md1) in
>> ext3_truncate:
>> >> Out
>> >> >> of memory
>> >> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
>> >> >> ext3_reserve_inode_write: Readonly filesystem
>> >> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
>> >> ext3_orphan_del:
>> >> >> Readonly filesystem
>> >> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
>> >> >> ext3_reserve_inode_write: Readonly filesystem
>> >> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
>> >> ext3_delete_inode:
>> >> >> Out of memory
>  <snip>
>
> 								Honza
> --
> Jan Kara <jack@suse.cz>
> SuSE CR Labs
>

