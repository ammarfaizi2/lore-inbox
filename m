Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWAOV0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWAOV0E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 16:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWAOV0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 16:26:04 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:51906 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750897AbWAOV0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 16:26:02 -0500
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.15: Filesystem capabilities 0.16
References: <8764om8pzl.fsf@goat.bogus.local>
	<200601142358.31628.ioe-lkml@rameria.de>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sun, 15 Jan 2006 22:25:56 +0100
Message-ID: <87zmlx5gkb.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ioe-lkml@rameria.de> writes:

> On Saturday 14 January 2006 22:21, Olaf Dietsche wrote:
>> This patch implements filesystem capabilities. It allows to run
>> privileged executables without the need for suid root.
>
> Why not implement this via xattr framework and the "system." 
> namespace there? I would suggest "system.posix_capabilties" for this.

This already exists. See
<http://groups.google.com/group/linux.kernel/browse_frm/thread/bbcb9a5d4204db6d/92da59d319865d7b>,
<http://groups.google.com/group/linux.kernel/browse_frm/thread/b8f2508c00c76938/d76a17c820b8a0a8>
and <http://www.stanford.edu/~luto/linux-fscap/>

> That way you can reduce your infrastructure, take advantage
> of caching features, have user space tools for viewing and changing 
> this and resize2fs works for it now or soon.
>
> What do you think?

Short (and lazy ;-) answer: <http://groups.google.com/group/linux.kernel/browse_frm/thread/6a4f4b26c110c742/83ad1d63035fd290>

Regards, Olaf.
