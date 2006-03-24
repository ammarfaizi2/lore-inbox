Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWCXCpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWCXCpm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 21:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWCXCpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 21:45:42 -0500
Received: from node-4024215a.mdw.onnet.us.uu.net ([64.36.33.90]:61430 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S964910AbWCXCpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 21:45:41 -0500
Date: Thu, 23 Mar 2006 20:45:40 -0600
From: Brandon Low <lostlogic@lostlogicx.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1
Message-ID: <20060324024540.GM27559@lostlogicx.com>
References: <20060323014046.2ca1d9df.akpm@osdl.org> <20060324021729.GL27559@lostlogicx.com> <20060323182411.7f80b4a6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323182411.7f80b4a6.akpm@osdl.org>
X-Operating-System: Linux found 2.6.16-rc5-mm3
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03/23/06 at 18:24:11 -0800, Andrew Morton wrote:
> Brandon Low <lostlogic@lostlogicx.com> wrote:
> >
> > I'm getting a repeatable oops regardless of io scheduler (it looks like
> > it's in cfq code so I first tried changing schedulers) on USB
> > disconnect.
> > 
> OK, thanks.  There have been some recent changes affecting iosched context
> lifetime management, which might be causing this.
> 
> If you have time, it'd be useful if you could retest with
> ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.16-git6.gz -
> that'll tell us whether it's that code or if it's something which is only
> in -mm.

Unable to reproduce with identical steps on git6.  Thanks for the
amazingly quick response!

Brandon
