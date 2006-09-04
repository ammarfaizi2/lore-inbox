Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbWIDXfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWIDXfW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 19:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWIDXfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 19:35:22 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:51869 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S965033AbWIDXfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 19:35:20 -0400
Date: Mon, 4 Sep 2006 19:34:54 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: Re: Re: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification Filesystem
Message-ID: <20060904233454.GC19836@filer.fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901115327.80554494.sfr@canb.auug.org.au> <20060901172310.GA2622@filer.fsl.cs.sunysb.edu> <Pine.LNX.4.61.0609031941210.12800@yvahk01.tjqt.qr> <20060903194456.GA4977@filer.fsl.cs.sunysb.edu> <84144f020609040401h314bdb72x4c3bd7c27cb38256@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020609040401h314bdb72x4c3bd7c27cb38256@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 02:01:41PM +0300, Pekka Enberg wrote:
> On 9/3/06, Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> >I think you misunderstood my comment. What I meant to say was that there is
> >_no way_ you can compile a filesystem that has only dentry ops but not
> >superblock ops - this would happen if you tried to bisect and you landed
> >half way in the series of commits for the filesystem. For the _initial_
> >commit one cset makes sense. For subsequent fixes one commit per fix is the
> >only logical thing to do.
> 
> Reorder the patches so that Makefile and Kconfig changes come last and
> git bisect will work just fine.

Already done.

Josef 'Jeff' Sipek.

-- 
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are, by
definition, not smart enough to debug it.
		- Brian W. Kernighan 
