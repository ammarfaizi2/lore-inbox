Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUGACVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUGACVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 22:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUGACVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 22:21:23 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:65485 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S263735AbUGACVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 22:21:22 -0400
Date: Wed, 30 Jun 2004 22:21:18 -0400 (EDT)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: Steven Newbury <steven.newbury1@ntlworld.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Trouble with the filesize limit
In-Reply-To: <1088647102.6630.15.camel@timescape.home.snewbury.org.uk>
Message-ID: <Pine.LNX.4.58.0406302211490.21486@vivaldi.madbase.net>
References: <1088647102.6630.15.camel@timescape.home.snewbury.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Jul 2004, Steven Newbury wrote:
> It isn't possible for me to download more than 2GiB.

> I've tried programs d4x, wget etc., each of them have received a
> SIGXFSZ and exited at 2GiB.

Probably none of those apps were compiled with
-D_FILE_OFFSET_BITS=64 ...

> Strangely I am able to create much larger files with dd.

That one probably is... (the coreutils configure script enables that
automatically)

Eric
