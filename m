Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbUD1VUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUD1VUa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbUD1VU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 17:20:27 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:60300 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S262142AbUD1VTg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 17:19:36 -0400
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: busterbcook@yahoo.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0404281534110.3044@ozma.hauschen>
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
	 <20040427230203.1e4693ac.akpm@osdl.org>
	 <Pine.LNX.4.58.0404280826070.31093@ozma.hauschen>
	 <20040428124809.418e005d.akpm@osdl.org>
	 <Pine.LNX.4.58.0404281534110.3044@ozma.hauschen>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083187174.2856.162.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Apr 2004 17:19:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-28 at 16:39, Brent Cook wrote:
> > Could you please capture the contents of /proc/meminfo and /proc/vmstats
> > when it's happening?
> >
> > Thanks.
> >
> 
> Here is the top of top for one machine:
> 
>  15:36:55  up  7:09,  1 user,  load average: 1.00, 1.00, 1.00
> 48 processes: 46 sleeping, 2 running, 0 zombie, 0 stopped
> CPU states:   0.1% user  99.8% system   0.0% nice   0.0% iowait   0.0% idle
> Mem:   256992k av,  117644k used,  139348k free,       0k shrd,   36464k buff
>         50968k active,              51592k inactive
> Swap:  514040k av,       0k used,  514040k free                   61644k cached
> 
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
>     7 root      25   0     0    0     0 RW   99.4  0.0 415:26   0 pdflush

Could you please also supply the mount options you are using as well as
the contents of /proc/mounts corresponding to your NFS partition.

Cheers,
  Trond
