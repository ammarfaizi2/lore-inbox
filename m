Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263467AbUGACpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbUGACpd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 22:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUGACpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 22:45:32 -0400
Received: from mta10-svc.ntlworld.com ([62.253.162.94]:22881 "EHLO
	mta10-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S263467AbUGACpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 22:45:31 -0400
Subject: Re: Trouble with the filesize limit
From: Steven Newbury <steven.newbury1@ntlworld.com>
To: Eric Lammerts <eric@lammerts.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0406302211490.21486@vivaldi.madbase.net>
References: <1088647102.6630.15.camel@timescape.home.snewbury.org.uk>
	 <Pine.LNX.4.58.0406302211490.21486@vivaldi.madbase.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1088649927.6630.21.camel@timescape.home.snewbury.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 01 Jul 2004 03:45:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the quick response.

On Thu, 2004-07-01 at 03:21, Eric Lammerts wrote:
> On Thu, 1 Jul 2004, Steven Newbury wrote:
> > It isn't possible for me to download more than 2GiB.
> 
> > I've tried programs d4x, wget etc., each of them have received a
> > SIGXFSZ and exited at 2GiB.
> 
> Probably none of those apps were compiled with
> -D_FILE_OFFSET_BITS=64 ...
> 
Okay I've recompiled wget with -D_FILE_OFFSET_BITS=64.  Now I've got:
get: progress.c:706: create_image: Assertion `insz <= dlsz' failed.
when I try to continue the download...

> > Strangely I am able to create much larger files with dd.
> 
> That one probably is... (the coreutils configure script enables that
> automatically)
> 
> Eric
-- 
Steven Newbury <steven.newbury1@ntlworld.com>
