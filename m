Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbULUSRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbULUSRY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 13:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbULUSRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 13:17:24 -0500
Received: from danga.com ([66.150.15.140]:48819 "EHLO danga.com")
	by vger.kernel.org with ESMTP id S261827AbULUSPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 13:15:43 -0500
Date: Tue, 21 Dec 2004 10:15:41 -0800 (PST)
From: Brad Fitzpatrick <brad@danga.com>
X-X-Sender: bradfitz@danga.com
To: Chris Swanson <chrisjswanson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Make changes to read-only file system using RAM
In-Reply-To: <1bdcbebf04122110087de9d976@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0412211015030.17405@danga.com>
References: <1bdcbebf04122110087de9d976@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris,

Check out unionfs.


On Tue, 21 Dec 2004, Chris Swanson wrote:

> Hi,
>
>     Has anyone seen any work done on a RAM based file system that
> stores only changes to what would otherwise have been a read-only file
> system?  For example, live Linux CD's rely on RAM file systems to
> store directories/files that must be modified, but the majority of the
> system is mounted read-only on the CD.  I was thinking it would be
> really nice if we could mount a read-only medium (like a CD) in
> read-write mode, and store only modifications in RAM.  This could give
> the illusion of a true read-write medium, and the RAM file system
> would just grow as more changes are made.
>     I have searched around a bit and found nothing like this.
> Unfortunately, I have no kernel programming experience (although I'd
> love to learn).  I was wondering if anyone has tried something similar
> in the past.  Also, if anyone with more experience can see any reason
> why this is impossible or impractical, I would love to hear it, before
> I come to the same conclusion many months down the line.
>
> Thanks for your time,
> Chris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
