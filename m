Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268425AbUIBPmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268425AbUIBPmK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 11:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268429AbUIBPmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 11:42:10 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:40638 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S268425AbUIBPmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 11:42:01 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 02 Sep 2004 17:40:46 +0200
To: schilling@fokus.fraunhofer.de, electronerd@monolith3d.com
Cc: linux-kernel@vger.kernel.org, der.eremit@email.de, christer@weinigel.se,
       axboe@suse.de
Subject: Re: (was: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices)
Message-ID: <41373EFE.nailBAN11FRB9@burner>
References: <2ptdY-42Y-55@gated-at.bofh.it>
 <2uPdM-380-11@gated-at.bofh.it> <2uUwL-6VP-11@gated-at.bofh.it>
 <2uWfh-8jo-29@gated-at.bofh.it> <2uXl0-Gt-27@gated-at.bofh.it>
 <2vge2-63k-15@gated-at.bofh.it> <2vgQF-6Ai-39@gated-at.bofh.it>
 <2vipq-7O8-15@gated-at.bofh.it> <2vj2b-8md-9@gated-at.bofh.it>
 <2vDtS-bq-19@gated-at.bofh.it> <E1ByXMd-00007M-4A@localhost>
 <412770EA.nail9DO11D18Y@burner> <412889FC.nail9MX1X3XW5@burner>
 <Pine.LNX.4.58.0408221450540.297@neptune.local>
 <m37jrr40zi.fsf@zoo.weinigel.se> <4134FA0B.6030404@monolith3d.com>
 <4136EB75.nailB22112H09@burner> <41372501.8050600@monolith3d.com>
In-Reply-To: <41372501.8050600@monolith3d.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Myers <electronerd@monolith3d.com> wrote:

> | cdrecord neither does drop the privileges by accident nor by malice.
>
> I wasn't trying to insult cdrecord, or even suggest it might have the
> inkling of a possibility of this type of issue, and I am sorry if I made
> it sound that way. I was merely trying to illustrate a use of my
> proposal. I admit, I should have invented a name, like
> cd-burning-fire-toaster-program to illustrate the separation of my
> example from any actual existing implementation

It was not you, but other people did write that cdrecord is broken
although only the kernel did change in an incompatible way.

> | On a cleanly designed OS with fine grained permissions, a program like
> cdrecord
> | does not need to worry about the permissions as it gets exactly the
> needed
> | permissions granted by the execution environment.
> |
> | Jörg
> |
>
> Which is exactly what I proposed...
>
>
> So... could anyone comment on my proposal, rather than just flame my
> examples?

I did not flame your examples, but if you thought of the same thigs, you may 
have been not obvious enough with your explanation.

On Solaris, this is done by /usr/bin/pfexec (the only suid root binary) that 
calls /usr/bin/ppriv -e which executes a process with the privilleges that are 
in the privilleges database.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
