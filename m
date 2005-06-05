Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVFEAId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVFEAId (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 20:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVFEAId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 20:08:33 -0400
Received: from mail.dvmed.net ([216.237.124.58]:6083 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261445AbVFEAI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 20:08:26 -0400
Message-ID: <42A24274.7040906@pobox.com>
Date: Sat, 04 Jun 2005 20:08:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Git Mailing List <git@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: git-shortlog script
References: <42A22C20.10002@pobox.com> <Pine.LNX.4.58.0506041642530.1876@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506041642530.1876@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 4 Jun 2005, Jeff Garzik wrote:
> 
>>Attached is the 'git-shortlog' script I whipped up, to mimic the 
>>shortlog script that was used back in the BitKeeper days.
> 
> 
> Thanks, I'll add this to the git stuff, and next kernel release will have 
> a proper shortlog.

cool


> Btw, it shows how broken your merge script is: you don't fill in the 
> AUTHOR field properly for some reason:
> 
>  <jgarzik@pretzel.yyz.us>:
>   Automatic merge of /spare/repo/netdev-2.6 branch r8169-fix
>   Automatic merge of /spare/repo/linux-2.6/.git branch HEAD
>   Automatic merge of /spare/repo/netdev-2.6 branch use-after-unmap
>   Automatic merge of rsync://rsync.kernel.org/.../torvalds/linux-2.6.git branch HEAD
> 
> but "committer" is right. Pls fix.

hehe, my merge script is Ctrl-R (recall last git-resolve-script invocation).

Committer is right because I set that in my .bash_profile.  I'll do that 
for author too, to provide a sane default.

I'm surprised git doesn't fall back to GIT_COMMITTER_NAME if 
GIT_AUTHOR_NAME doesn't exist, though.

	Jeff


