Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbTLGAHu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 19:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265277AbTLGAHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 19:07:49 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:21395
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S265276AbTLGAHs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 19:07:48 -0500
Date: Sat, 6 Dec 2003 19:16:50 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
Message-ID: <20031206191650.A4199@animx.eu.org>
References: <Law9-F31u8ohMschTC00001183f@hotmail.com> <Pine.LNX.4.58.0312060011130.2092@home.osdl.org> <3FD1994C.10607@stinkfoot.org> <20031206084032.A3438@animx.eu.org> <Pine.LNX.4.58.0312061044450.2092@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.58.0312061044450.2092@home.osdl.org>; from Linus Torvalds on Sat, Dec 06, 2003 at 01:57:03PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > At the moment, I don't have a burner on a 2.6.0 machine, however, why is
> > ide-scsi depreciated?
> 
> Several reasons.
> 
> One is just plain confusion - anybody who uses cdrecord has either been
> confused by the silly SCSI numbering (while "dev=/dev/hdc" is not
> confusing at all, and uses the same device you use for mounting the thing
> etc).

Actually, itwould be nice if I could use dev=/dev/scd0.  I do have a scsi
burner (and an ide one too)

> Another is that several things did _not_ work well with ide-scsi. Some
> people ended up having to boot with ide-scsi enabled to burn CD's, but
> then if they wanted to watch DVD's (on the same drive), they needed to
> boot without it.

The joys of modules =)

> >		 On every PC I have that has an ide cd drive, I use
> > ide-scsi.  I like the fact that scd0 is the cdrom drive.
> 
> And you liked the fact that you were supposed to write "dev=0,0,0" or
> something strange like that? What a piece of crap it was.

I have it named using cdrecord's defaults.  People who have real scsi
burners still have to use that format.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
