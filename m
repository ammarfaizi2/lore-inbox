Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030526AbVKXA2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030526AbVKXA2P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 19:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbVKXA2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 19:28:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1467 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030526AbVKXA2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 19:28:11 -0500
Date: Wed, 23 Nov 2005 16:27:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc2-mm1
Message-Id: <20051123162755.68b663d7.akpm@osdl.org>
In-Reply-To: <20051124012027.228d5e2f@werewolf.auna.net>
References: <20051123033550.00d6a6e8.akpm@osdl.org>
	<20051124012027.228d5e2f@werewolf.auna.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> On Wed, 23 Nov 2005 03:35:50 -0800, Andrew Morton <akpm@osdl.org> wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc2/2.6.15-rc2-mm1/
> > 
> > (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.15-rc2-mm1.gz)
> > 
> > - Added git-sym2.patch to the -mm lineup: updates to the sym2 scsi driver
> >   (Matthew Wilcox).  
> > 
> > - The JSM tty driver still doesn't compile.
> > 
> > - The git-powerpc tree is included now.
> > 
> 
> Bad news :(.
> It hangs when trying to start cups.
> My initscripts just say "Loading USB printer module" and hang there.
> No sysrq-t, no sysrq-b.
> I suppose it tries to load usblp.

You could try disabling cups and then run `modprobe usblp' when the system
is fully booted.  Make sure that sysrq-t is generating stuff before doing
so.

> Any idea about the patch to blame ?

Not at this stage.
