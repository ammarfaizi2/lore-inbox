Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266550AbUHINOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266550AbUHINOl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 09:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUHINOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 09:14:41 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:60058 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266550AbUHINOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 09:14:40 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Albert Cahalan <albert@users.sf.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: albert@users.sourceforge.net,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200408091156.i79Bu6ap009600@burner.fokus.fraunhofer.de>
References: <200408091156.i79Bu6ap009600@burner.fokus.fraunhofer.de>
Content-Type: text/plain
Organization: 
Message-Id: <1092048174.5759.207.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Aug 2004 06:42:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 07:56, Joerg Schilling wrote:
> >From: Albert Cahalan <albert@users.sourceforge.net>
> 
> >> 5) Take a look at /etc/path_to_inst and call "man path_to_inst"
> >>
> >> The used method even works nicely for USB devices.
> 
> >OK, I took a look.
> 
> You obviously did not :-(
> 
> Please don't try to comment things you did not verify with a
> running Solaris.

If the behavior doesn't match the man page, it's buggy.

Looking through your source code, I see that several
additional OSes can handle addressing by device name,
but you've disabled this for them. I pity the users.
It's even obvious how to use drive letters on NT.

I would be happy to maintain a decent cdrecord, provided
that somebody can find me some funding. This would take
a great deal more time than procps does currently.
It would require a never-ending supply of blank disks
and, at least initially, a pile of hardware.

I'm not kidding. If some Linux distributer or Linux .org
can fund me (my kids like to eat), I'll fix this problem.


