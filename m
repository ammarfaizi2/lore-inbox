Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVFZSkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVFZSkx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 14:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVFZSkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 14:40:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37253 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261553AbVFZSjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 14:39:52 -0400
Date: Sun, 26 Jun 2005 19:39:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, paulus@samba.org,
       eich@pdx.freedesktop.org
Subject: Re: [git patch] DRM 32/64 ioctl patch..
Message-ID: <20050626183948.GA21318@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	paulus@samba.org, eich@pdx.freedesktop.org
References: <Pine.LNX.4.58.0506261313390.3269@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506261313390.3269@skynet>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 01:22:56PM +0100, Dave Airlie wrote:
> 
> Hi Linus,
> 	Please pull the 'drm-3264' branch of
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git
> 
> This contains the initial patch from Paul Mackerras, for supporting
> radeons on 32/64 systems, I'll try and submit patches for other chips
> later as people get them working.
> 
> The patch is at
> http://www.skynet.ie/~airlied/patches/lk_drm/drm_3264_git.diff
> for anyone else interested.

I talked to Egbert Eich at Linuxtag and he said he had different compat
ioctl patch for drm, which actually supports running a 64bit server
and 32bit clients.

The big question is here, does this patch help to reach this goal or does
it make that more awkward?

