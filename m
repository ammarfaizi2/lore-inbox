Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWGXHIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWGXHIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 03:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWGXHIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 03:08:55 -0400
Received: from xenotime.net ([66.160.160.81]:41175 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751430AbWGXHIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 03:08:55 -0400
Date: Mon, 24 Jul 2006 00:11:28 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, clameter@sgi.com,
       linux-mm@kvack.org
Subject: Re: [PATCH] Add maintainer for memory management
Message-Id: <20060724001128.6d513d20.rdunlap@xenotime.net>
In-Reply-To: <1153713707.4002.43.camel@localhost.localdomain>
References: <1153713707.4002.43.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006 00:01:47 -0400 Steven Rostedt wrote:

> I recently realized that there's no listing of a memory management
> maintainer in the MAINTAINERS file. And didn't know about
> linux-mm@kvack.org before Ingo enlightened me.  So I've decided to add
> one.  Since Christoph is the first person to come in my mind as the
> proper maintainer, (and I haven't asked him if he wants this title :)
> I'll let him either add others to the list, or replace his name
> altogether.
> 
> (I also used the email that he had in slab.c)
> 
> Note: If someone else is more likely the person than Christoph, don't be
> offended that I didn't choose you.  It's just that Christoph has
> responded the most whenever I mention anything about memory. So I chose
> that as my criteria, than looking at who submits the most memory
> patches.
> 
> -- Steve
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Index: linux-2.6.18-rc2/MAINTAINERS
> ===================================================================
> --- linux-2.6.18-rc2.orig/MAINTAINERS	2006-07-23 23:32:13.000000000 -0400
> +++ linux-2.6.18-rc2/MAINTAINERS	2006-07-23 23:34:10.000000000 -0400
> @@ -1884,6 +1884,12 @@ S:     linux-scsi@vger.kernel.org
>  W:     http://megaraid.lsilogic.com
>  S:     Maintained
>  
> +MEMORY MANAGEMENT
> +P:	Christoph Lameter
> +M:	christoph@lameter.com
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +

Christoph L. is very NUMA & big-iron focused.  He also breaks
things (at least builds if not working code) a bit too often IMO.

Andrew, Nick, Peter Zijlstra, Pekka, Manfred, Hugh Dickins
are all a better choice IMO.  However, if Andrew & Linus want
to merge that one...

---
~Randy
