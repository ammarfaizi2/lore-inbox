Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbUBOXrP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 18:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbUBOXrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 18:47:15 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:11994 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265236AbUBOXrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 18:47:14 -0500
Date: Sun, 15 Feb 2004 18:47:11 -0500
From: Willem Riede <wrlk@riede.org>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove obsolete onstream support from ide-tape in 2.6.3-rc3
Message-ID: <20040215234711.GC4957@serve.riede.org>
Reply-To: wrlk@riede.org
References: <20040215221108.GA4957@serve.riede.org> <20040215153214.002dcc9a.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040215153214.002dcc9a.pj@sgi.com> (from pj@sgi.com on Sun, Feb 15, 2004 at 18:32:14 -0500)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.02.15 18:32, Paul Jackson wrote:
> And another obsolete tape drive goes on my vintage shelf.
> 
> Willem - I notice off SourceForge a note:
> 
>   http://sourceforge.net/forum/forum.php?forum_id=333748
> 
>   Posted By: wriede
>   Date: 2003-12-01 16:24
>   Summary: osst, the Linux OnStream Tape driver now avalable on sf.net
> 
>   Following the unfortunate bankruptcy of OnStream, I have now completed
>   the migration of the osst CVS repository, web site and mailing list to
>   SourceForge.
> 
>   Willem Riede,
>   osst maintainer.
> 
> How does this relate to your removal of onstream from 2.6?  I'm guessing
> that you are maintaining onstream in 2.4, but not in 2.6 or beyond.  But
> that's just a guess.

I am maintaining osst, which is available in both 2.4 and 2.6. It works very 
well, and the DI-30 is supported by it through ide-scsi. In contrast, 
onstream code in ide-tape has not been maintained, and is buggy. To ease my 
work, I want osst to be the only onstream code in the kernel.

So the "obsolete" refers to ide-tape's implementation only, not the drive.

Regards, Willem Riede.
