Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbTEHGjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 02:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTEHGjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 02:39:08 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:15630 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261185AbTEHGjH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 02:39:07 -0400
Date: Thu, 8 May 2003 08:54:40 +0200
To: William Lee Irwin III <wli@holomorphy.com>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, akpm@digeo.com
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
Message-ID: <20030508065440.GA1890@hh.idb.hist.no>
References: <3EB8E4CC.8010409@aitel.hist.no> <20030507.025626.10317747.davem@redhat.com> <20030507144100.GD8978@holomorphy.com> <20030507.064010.42794250.davem@redhat.com> <20030507215430.GA1109@hh.idb.hist.no> <20030508013854.GW8931@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508013854.GW8931@holomorphy.com>
User-Agent: Mutt/1.5.3i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 06:38:54PM -0700, William Lee Irwin III wrote:
[...] 
> Can you try one kernel with the netfilter cset backed out, and another
> with the re-slabification patch backed out? (But not with both backed
> out simultaneously).

I'm compiling without reslabify now.
I got 
patching file arch/i386/mm/pageattr.c
Hunk #1 succeeded at 67 (offset 9 lines).
when backing it out - is this the effect of
some other patch touching the same file or could
my source be wrong somehow?

Which patch is the netfilter cset?  None of
the patches in mm2 looked obvious to me.  Or
is it part of the linus patch? Note that mm1
works for me, so anything found there too
isn't as likely to be the problem.

Helge Hafting
