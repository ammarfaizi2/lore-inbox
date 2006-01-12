Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932670AbWALAR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbWALAR2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbWALAR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:17:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29960 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932670AbWALAR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:17:27 -0500
Date: Thu, 12 Jan 2006 01:17:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, edwardsg@sgi.com, linux-altix@sgi.com
Subject: Re: 2.6.15-mm3: arch/ia64/sn/kernel/sn2/sn_proc_fs.c compile error
Message-ID: <20060112001726.GK29663@stusta.de>
References: <20060111042135.24faf878.akpm@osdl.org> <20060111234133.GI29663@stusta.de> <20060111160121.77d57626.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111160121.77d57626.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 04:01:21PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > Arjan, it seems the following compile error on ia64 is caused by a patch 
> >  of you that makes some stuff static:
> > 
> >  <--  snip  -->
> > 
> >  ...
> >    CC      arch/ia64/sn/kernel/sn2/sn_proc_fs.o
> >  arch/ia64/sn/kernel/sn2/sn_proc_fs.c: In function 'sn_procfs_create_entry':
> >  arch/ia64/sn/kernel/sn2/sn_proc_fs.c:104: warning: passing argument 1 of 'memset' discards qualifiers from pointer target type
> >  arch/ia64/sn/kernel/sn2/sn_proc_fs.c:105: error: assignment of read-only member 'open'
> >  arch/ia64/sn/kernel/sn2/sn_proc_fs.c:106: error: assignment of read-only member 'read'
> >  arch/ia64/sn/kernel/sn2/sn_proc_fs.c:107: error: assignment of read-only member 'llseek'
> >  arch/ia64/sn/kernel/sn2/sn_proc_fs.c:108: error: assignment of read-only member 'release'
> >  arch/ia64/sn/kernel/sn2/sn_proc_fs.c: In function 'register_sn_procfs':
> >  arch/ia64/sn/kernel/sn2/sn_proc_fs.c:140: error: assignment of read-only member 'write'
> 
> This?
>...

Nearly.

The last compile error (line 140) is still present.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

