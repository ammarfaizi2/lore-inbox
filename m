Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWBXXue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWBXXue (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 18:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWBXXue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 18:50:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6038 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964801AbWBXXue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 18:50:34 -0500
Date: Fri, 24 Feb 2006 15:52:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: teigland@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: GFS2 Filesystem [0/16]
Message-Id: <20060224155237.7ab0c56e.akpm@osdl.org>
In-Reply-To: <1140792511.6400.707.camel@quoit.chygwyn.com>
References: <1140792511.6400.707.camel@quoit.chygwyn.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Whitehouse <swhiteho@redhat.com> wrote:
>
> The following 16 patches make up the GFS2 filesystem as contained in the
> git tree at:
> 
> http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=summary
> 
> Please consider GFS2 for inclusion in your -mm series of kernel patches.

Once the various review comments are sorted out I'd prefer that both DLM
and GFS be maintained by you in your git tree (like OCFS2 prior to and
after merge).

That's the most convenient thing for both you and me.  It has the downside
that putting things into git trees tends to hide them from view.  And GFS
needs a lot of viewing before it can proceed further.  That's an ongoing
problem with the git trees.

So, in a way, maintaining DLM and GFS in git trees as I suggest is likely
to retard an upstream merge.   But it would be more convenient.

Helpful, aren't I?
