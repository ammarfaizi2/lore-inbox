Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWCEWok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWCEWok (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 17:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWCEWok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 17:44:40 -0500
Received: from cantor2.suse.de ([195.135.220.15]:25575 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932165AbWCEWok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 17:44:40 -0500
Date: Sun, 5 Mar 2006 23:44:38 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16-rc5
Message-ID: <20060305224438.GA22580@suse.de>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060305140932.GA17132@suse.de> <20060305185923.GA21519@suse.de> <Pine.LNX.4.64.0603051147590.13139@g5.osdl.org> <20060305204231.GA22002@suse.de> <17419.23860.883220.80199@cargo.ozlabs.ibm.com> <20060305222202.GA22450@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060305222202.GA22450@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Mar 05, Olaf Hering wrote:

> 404849bbd2bfd62e05b36f4753f6e1af6050a824 + 3 buildfixes:
> 
> 31df1678d7732b94178a6e457ed6666e4431212f
> 8dacaedf04467e32c50148751a96150e73323cdc
> d2dd482bc17c3bc240045f80a7c4b4d5cea5e29c
> 
> 
> This one has the syscall changes, but not the two fixes you mentioned.
> It gets far, but at the point where it locks up with the d4eb, it
> crashes in run_timer_softirq, branched to 0x1f4. Maybe its the result of
> the missing fixes. Will continue tomorrow.

Another try with that version, now I see the corruption before the
package where it locked up before (glibc-locale, rather large).
Will backout the syscall change and try again with 404849bbd2bfd62e05b36f4753f6e1af6050a824.

ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234, item_len 25965, item_location 25972, free_space(entry_count) 24946
ReiserFS: hda11: warning: vs-5150: search_by_key: invalid format found in block 0. Fsck?
ReiserFS: hda11: warning: zam-7001: io error in reiserfs_find_entry
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234, item_len 25965, item_location 25972, free_space(entry_count) 24946
ReiserFS: hda11: warning: vs-5150: search_by_key: invalid format found in block 0. Fsck?
ReiserFS: hda11: warning: zam-7001: io error in reiserfs_find_entry
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234, item_len 25965, item_location 25972, free_space(entry_count) 24946
ReiserFS: hda11: warning: vs-5150: search_by_key: invalid format found in block 0. Fsck?
ReiserFS: hda11: warning: zam-7001: io error in reiserfs_find_entry
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234, item_len 25965, item_location 25972, free_space(entry_count) 24946
ReiserFS: hda11: warning: vs-5150: search_by_key: invalid format found in block 0. Fsck?
ReiserFS: hda11: warning: zam-7001: io error in reiserfs_find_entry
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234, item_len 25965, item_location 25972, free_space(entry_count) 24946
ReiserFS: hda11: warning: vs-5150: search_by_key: invalid format found in block 0. Fsck?
ReiserFS: hda11: warning: zam-7001: io error in reiserfs_find_entry
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234, item_len 25965, item_location 25972, free_space(entry_count) 24946
ReiserFS: hda11: warning: vs-5150: search_by_key: invalid format found in block 0. Fsck?
ReiserFS: hda11: warning: zam-7001: io error in reiserfs_find_entry
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234, item_len 25965, item_location 25972, free_space(entry_count) 24946
ReiserFS: hda11: warning: vs-5150: search_by_key: invalid format found in block 0. Fsck?
ReiserFS: hda11: warning: zam-7001: io error in reiserfs_find_entry
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234, item_len 25965, item_location 25972, free_space(entry_count) 24946
ReiserFS: hda11: warning: vs-5150: search_by_key: invalid format found in block 0. Fsck?
ReiserFS: hda11: warning: zam-7001: io error in reiserfs_find_entry
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234, item_len 25965, item_location 25972, free_space(entry_count) 24946
ReiserFS: hda11: warning: vs-5150: search_by_key: invalid format found in block 0. Fsck?
ReiserFS: hda11: warning: zam-7001: io error in reiserfs_find_entry
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234
ReiserFS: warning: vs-500: unknown uniqueness 1634738234, item_len 25965, item_location 25972, free_space(entry_count) 24946
ReiserFS: hda11: warning: vs-5150: search_by_key: invalid format found in block 0. Fsck?
ReiserFS: hda11: warning: zam-7001: io error in reiserfs_find_entry


