Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264177AbRFFWud>; Wed, 6 Jun 2001 18:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264187AbRFFWuX>; Wed, 6 Jun 2001 18:50:23 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:48905 "HELO
	clueserver.org") by vger.kernel.org with SMTP id <S264177AbRFFWuQ>;
	Wed, 6 Jun 2001 18:50:16 -0400
Date: Wed, 6 Jun 2001 17:00:59 -0700 (PDT)
From: Alan Olsen <alan@clueserver.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Alan Cox <laughing@shared-source.org>
Subject: Re: SCSI is as SCSI don't...
In-Reply-To: <E157Y4j-0007yX-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10106061653380.20994-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Alan Cox wrote:

> > I am trying to get 2.4.5 and/or 2.4.5-ac9 working.  Both are choking on
> > compile with an odd error message or four...
> > 
> > In file included from /usr/src/linux-2.4.5-ac9/include/linux/raid/md.h:50,
> >                  from ll_rw_blk.c:30:
> > /usr/src/linux-2.4.5-ac9/include/linux/raid/md_k.h: In function
> > `pers_to_level':/usr/src/linux-2.4.5-ac9/include/linux/raid/md_k.h:41:
> > warning: control reaches end of non-void function
> 
> That is just a warning caused by a C compiler bug and harmless. The sg case
> you report I've seen random variants of caused by burner bugs, software bugs
> and scsi layer bugs - I dont know what it would be and you didnt give enough
> info

Sorry.

The boot problems I believe were caused by "kernel building under the
influence of sleep deprivation".  I rebuilt and things are working fine.

I have added extra SCSI and kernel debugging to try and track down the
issues with the burner software.  (It has been pretty stable up until now.
At least it is not burning weird hallucinatory things to disc, like one of
the previous version did.  Just glad I found out before burning backups.)

Sorry for the non-error and even more worthless bug report. (I need more
caffiene...)

However, the compile problem with 2.4.5-ac9 seems real enough.  The link
problems do not go away until I build in the joystick drivers into the
kernel. (Building them as modules did not work, but may have been a
mismatch between the joystick support built in to the kernel and the
drivers built as modules.)

Thanks for the quick reply.

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
 "All power is derived from the barrel of a gnu." - Mao Tse Stallman

