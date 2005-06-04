Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVFDXnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVFDXnT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 19:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVFDXnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 19:43:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:39589 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261434AbVFDXnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 19:43:13 -0400
Date: Sat, 4 Jun 2005 16:45:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Git Mailing List <git@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: git-shortlog script
In-Reply-To: <42A22C20.10002@pobox.com>
Message-ID: <Pine.LNX.4.58.0506041642530.1876@ppc970.osdl.org>
References: <42A22C20.10002@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Jun 2005, Jeff Garzik wrote:
> 
> Attached is the 'git-shortlog' script I whipped up, to mimic the 
> shortlog script that was used back in the BitKeeper days.

Thanks, I'll add this to the git stuff, and next kernel release will have 
a proper shortlog.

Btw, it shows how broken your merge script is: you don't fill in the 
AUTHOR field properly for some reason:

 <jgarzik@pretzel.yyz.us>:
  Automatic merge of /spare/repo/netdev-2.6 branch r8169-fix
  Automatic merge of /spare/repo/linux-2.6/.git branch HEAD
  Automatic merge of /spare/repo/netdev-2.6 branch use-after-unmap
  Automatic merge of rsync://rsync.kernel.org/.../torvalds/linux-2.6.git branch HEAD

but "committer" is right. Pls fix.

		Linus
