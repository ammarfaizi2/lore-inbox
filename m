Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbTF3Nm3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 09:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTF3Nm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 09:42:29 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:53244 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263743AbTF3Nm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 09:42:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: File System conversion -- ideas
Date: Mon, 30 Jun 2003 08:56:23 -0500
X-Mailer: KMail [version 1.2]
Cc: rmoser <mlmoser@comcast.net>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <03063008265401.14007@tabby> <3F003E40.1040902@namesys.com>
In-Reply-To: <3F003E40.1040902@namesys.com>
MIME-Version: 1.0
Message-Id: <03063008562302.14007@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 June 2003 08:42, Hans Reiser wrote:
> Jesse Pollard wrote:
[snip]
> >>no, in-kernel conversion between everything.  You don't think it can be
> >>done? It's not that difficult a problem to manage data like that :D
> >
> >You are ASSUMING that the new filesystem requires lessthan or equal amount
> >of metadata. This is NOT always true. A conversion of a full EXT2 to
> > Riserfs would fail simply because there is no free space to expand the
> > needed additional overhead.
>
> Uh, you mean converting reiserfs to ext2 would fail.... we are more
> space efficient....

yes. stupid me got the order backward.

