Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbTE1MZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 08:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264706AbTE1MZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 08:25:56 -0400
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:22290 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S264704AbTE1MZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 08:25:55 -0400
Date: Wed, 28 May 2003 14:38:43 +0200
From: Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Andrew Morton <akpm@digeo.com>, axboe@suse.de, m.c.p@wolk-project.de,
       kernel@kolivas.org, manish@storadinc.com, andrea@suse.de,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030528123843.GA714@rz.uni-karlsruhe.de>
Mail-Followup-To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Andrew Morton <akpm@digeo.com>, axboe@suse.de,
	m.c.p@wolk-project.de, kernel@kolivas.org, manish@storadinc.com,
	andrea@suse.de, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
References: <200305280930.48810.m.c.p@wolk-project.de> <20030528073544.GR845@suse.de> <20030528005156.1fda5710.akpm@digeo.com> <20030528101348.GA804@rz.uni-karlsruhe.de> <20030528032315.679e77b0.akpm@digeo.com> <20030528121040.GA1193@rz.uni-karlsruhe.de> <20030528121446.GB1193@rz.uni-karlsruhe.de> <3ED4A9B4.1050907@gmx.net> <20030528122308.GC1193@rz.uni-karlsruhe.de> <3ED4AB5A.3010408@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED4AB5A.3010408@gmx.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 02:28:10PM +0200, Carl-Daniel Hailfinger wrote:
> Matthias Mueller wrote:
> > On Wed, May 28, 2003 at 02:21:08PM +0200, Carl-Daniel Hailfinger wrote:
> > 
> >>Matthias Mueller wrote:
> >>
> >>>On Wed, May 28, 2003 at 02:10:40PM +0200, Matthias Mueller wrote:
> >>>
> >>>
> >>>>Tested all of them and some combinations:
> >>>>patch 1 alone:    hangs, no zombies
> >>>>patch 2 alone:    hangs, no zombies
> >>>>patch 3 alone: no hangs,    zombies
> >>>>patch 1+2:     no hangs, no zombies
> >>>>patch 1+2+3:   no hangs, no zombies
> 
> Right?
Yes.
