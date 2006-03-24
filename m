Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWCXDBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWCXDBi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 22:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbWCXDBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 22:01:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59847 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751529AbWCXDBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 22:01:38 -0500
Date: Thu, 23 Mar 2006 18:58:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brandon Low <lostlogic@lostlogicx.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1
Message-Id: <20060323185810.3bf2a4ce.akpm@osdl.org>
In-Reply-To: <20060324024540.GM27559@lostlogicx.com>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	<20060324021729.GL27559@lostlogicx.com>
	<20060323182411.7f80b4a6.akpm@osdl.org>
	<20060324024540.GM27559@lostlogicx.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brandon Low <lostlogic@lostlogicx.com> wrote:
>
> On Thu, 03/23/06 at 18:24:11 -0800, Andrew Morton wrote:
>  > Brandon Low <lostlogic@lostlogicx.com> wrote:
>  > >
>  > > I'm getting a repeatable oops regardless of io scheduler (it looks like
>  > > it's in cfq code so I first tried changing schedulers) on USB
>  > > disconnect.
>  > > 
>  > OK, thanks.  There have been some recent changes affecting iosched context
>  > lifetime management, which might be causing this.
>  > 
>  > If you have time, it'd be useful if you could retest with
>  > ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.16-git6.gz -
>  > that'll tell us whether it's that code or if it's something which is only
>  > in -mm.
> 
>  Unable to reproduce with identical steps on git6.

ok..

I tried various combinations of plugging, mounting, unmounting and
unplugging a USB memory stick.  No problems.

Can you prepare a step-by-step guide to making this happen?

Thanks.
