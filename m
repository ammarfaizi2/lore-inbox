Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291426AbSBHFw1>; Fri, 8 Feb 2002 00:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291429AbSBHFwS>; Fri, 8 Feb 2002 00:52:18 -0500
Received: from angband.namesys.com ([212.16.7.85]:23685 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S291426AbSBHFv5>; Fri, 8 Feb 2002 00:51:57 -0500
Date: Fri, 8 Feb 2002 08:51:56 +0300
From: Oleg Drokin <green@namesys.com>
To: Alex Riesen <fork0@users.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files resiserfs
Message-ID: <20020208085155.A7034@namesys.com>
In-Reply-To: <20020207082348.A26413@riesen-pc.gr05.synopsys.com> <20020207104420.A6824@namesys.com> <20020207230235.A173@steel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020207230235.A173@steel>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Feb 07, 2002 at 11:02:35PM +0100, Alex Riesen wrote:

> The reiserfsck showed up some nasty looking errors:
>  shrink_id_map: objectid map shrinked: used 4096, 5 blocks
>  grow_id_map: objectid map expanded: used 5120, 5 blocks
>  grow_id_map: objectid map expanded: used 10240, 10 blocks
>  bad_leaf: block 211482 has wrong order of items
>  ...more of that...
>  free block count 1326452 mismatches with a correct one 1326458.
>  on-disk bitmap does not match to the correct one. 1 bytes differ

Have you mkreiserfs'ed your partition before testing the patch I've sent you?
Or have you at least made a reiserfsck before a test run to ensure,
these corruptions are not from the previous kernels (particularly
bad_leaf: block 211482 has wrong order of items record worries me)

> "reiserfsck --rebuild-tree" cured them without visible damages for now.
> There were some messages about deleted blocks, expanded objectid map,
> shrinked map and one "dir 1 2 has wrong sd_size 120, has to be 152".
> I can send you logs, if needed.
Sure, please do.

> Does the 2.5.4-pre2 contains this patch ?
Yes.

Thank you.

Bye,
    Oleg
