Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUBDNKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 08:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbUBDNKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 08:10:31 -0500
Received: from www.trustcorps.com ([213.165.226.2]:52745 "EHLO raq1.nitrex.net")
	by vger.kernel.org with ESMTP id S261262AbUBDNKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 08:10:30 -0500
Message-ID: <4020EEB0.50002@hcunix.net>
Date: Wed, 04 Feb 2004 13:08:00 +0000
From: the grugq <grugq@hcunix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <20040204004318.GA253@elf.ucw.cz> <20040204062936.GA2663@thunk.org>
In-Reply-To: <20040204062936.GA2663@thunk.org>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> The obvious thing to do would be to make it a mount option, so that
> (a) recompilation is not necessary in order to use the feature, and
> (b) the feature can be turned on or off on a per-filesystem feature.
> In 2.6, it's possible to specify certain mount option to be specifed
> by default on a per-filesystem basis (via a new field in the
> superblock).  
> 
> So if you do things that way, then secure deletion would take place
> either if the secure deletion flag is set (so it can be enabled on a
> per-file basis), or if the filesystem is mounted with the
> secure-deletion mount option.  

Makes sense to me. If either the file system, or the file, are in 
'secure delete' mode, then erase everything about the file. Allowing the 
paranoid to have the option as default, and the concerned to target 
specific files. I like it.


peace,

--gq
