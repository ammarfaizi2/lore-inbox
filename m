Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269972AbUJNEV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269972AbUJNEV6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 00:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269967AbUJNEV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 00:21:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:4331 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269972AbUJNEVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 00:21:45 -0400
Date: Wed, 13 Oct 2004 21:21:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: John Byrne <john.l.byrne@hp.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Still a mm bug in the fork error path
In-Reply-To: <416CA0B1.20900@hp.com>
Message-ID: <Pine.LNX.4.58.0410132121110.3897@ppc970.osdl.org>
References: <416C6915.9080201@hp.com> <Pine.LNX.4.58.0410121902100.3897@ppc970.osdl.org>
 <416CA0B1.20900@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Oct 2004, John Byrne wrote:
>
> In my kernel, it was a SIGKILL to a forking kernel thread that caused 
> the problem. While I see SIGKILLs being sent to some kernel threads, I 
> don't know if any of the kernel threads ever fork. If they don't, 
> barring a demented root user sending SIGKILLs to kernel threads, I don't 
> know if anyone else will ever see this. So, I don't have any problems 
> with it being fixed post 2.6.9.

Heh. Andrew picked up the patch anyway, so in it goes.

		Linus
