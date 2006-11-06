Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753586AbWKFRh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbWKFRh6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 12:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753590AbWKFRh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 12:37:58 -0500
Received: from [212.33.163.145] ([212.33.163.145]:5249 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1753586AbWKFRh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 12:37:57 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-fsdevel@vger.kernel.org
Subject: Re: New filesystem for Linux
Date: Mon, 6 Nov 2006 20:40:44 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200611062040.44868.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> On 11/4/06, Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> > Albert Cahalan <acahalan@gmail.com> wrote:
> > > BTW, a person with disk recovery experience told me that drives
> > > will sometimes reorder the sectors. Sector 42 becomes sector 7732,
> > > sector 880880 becomes sector 12345, etc. The very best filesystems
> > > can handle with without data loss. (for example, ZFS) Merely great
> > > filesystems will at least recognize that the data has been trashed.
> >
> > Uh? This should be transparent to the host computer, so logical sector
> > numbers won't change.
>
> "should be" does not imply "won't"   :-)
>
> On a drive which is capable of remapping sectors, imagine what
> happens if the remapping data itself is corrupted. (the user data
> is perfectly fine and is not being relocated)

I would consider this a defective drive.

> What I mean is that the logical sector numbers not only change,
> but they are the only thing changing. The user data never moves
> to a different physical location, and is never intended to move.
> The user data is perfectly readable. It just appears in the wrong
> place as viewed by the OS.

Just like defective drive electronics; the data is ok, but the electronics 
corrupts the I/O.

No FS could help you there, AFAIK.

BTW, why is this thread not on fsdevel?


Thanks!

--
Al

