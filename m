Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263497AbTKKN46 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 08:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263500AbTKKN46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 08:56:58 -0500
Received: from 30.Red-80-36-33.pooles.rima-tde.net ([80.36.33.30]:65516 "EHLO
	linalco.com") by vger.kernel.org with ESMTP id S263497AbTKKN45
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 08:56:57 -0500
Date: Tue, 11 Nov 2003 14:59:48 +0100
From: Ragnar Hojland Espinosa <ragnar@linalco.com>
To: Philippe <rouquier.p@wanadoo.fr>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs 3.6 problem with test9
Message-ID: <20031111135948.GA5229@linalco.com>
References: <1068553197.1018.43.camel@Genesyme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068553197.1018.43.camel@Genesyme>
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 01:19:57PM +0100, Philippe wrote:
> Hello,
> recently I noticed some annoying problems whenever I try to access some
> files on my harddrive (reiserfs filesystem). I get "permission denied"
> even if I am the owner or if I try as root. dmesg answers the following
> for every file (so it's repeated):
> 
> is_tree_node: node level 30065 does not match to the expected one 1
> vs-5150: search_by_key: invalid format found in block 2554621. Fsck?
> vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to
> find stat data of [1000086 2592 0x0 SD]
> 
> I rebuilt my filesystem with reiserfsck (3.6.11) and it worked, I could
> read and write again these files. but soon after the rebuilt some other
> files (they were not concerned by this problem before) appeared to have
> the same problem and their number kept growing until I rebuilt again the
> filesystem ... but again new ones appeared after an hour or two ...

Last time I had a box with similar problems it was memory.  I'd put
your system through a memtest.
-- 
Ragnar Hojland - Project Manager
Linalco "Specialists in Linux and Free Software"
http://www.linalco.com  Tel: +34-91-4561700
