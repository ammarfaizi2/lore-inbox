Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265295AbTL0CDp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 21:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265296AbTL0CDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 21:03:45 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:22438
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S265295AbTL0CDo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 21:03:44 -0500
Date: Fri, 26 Dec 2003 21:09:51 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Willem Riede <wrlk@riede.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The survival of ide-scsi in 2.6.x
Message-ID: <20031226210951.B28322@animx.eu.org>
References: <20031226181242.GE1277@linnie.riede.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20031226181242.GE1277@linnie.riede.org>; from Willem Riede on Fri, Dec 26, 2003 at 01:12:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I know that many feel that ide-scsi is useless, and should go away.
> And you are probably tired of message threads talking about it.
> Yet I ask respectfully that you hear me out, and give me feedback.
> 
> So can we agree to keep ide-scsi? I know it is not desired any
> more for cd writers. To avoid the problem reports from people who
> don't realize that and select ide-scsi anyway, we can refuse to
> attach to a cd-type device (today it just warns). And/or make a 
> new explicit module parameter to tell ide-scsi exactly which 
> drives to attach to.
> 
> Today, ide-scsi is buggy, and that needs fixing. The underlying
> problem is that ide-scsi stands with one leg in the IDE world and
> one leg in the SCSI world, which creates the challenge to make
> the IDE error recovery work in sync with, and under the direction of 
> the SCSI error handler.

I have a better idea (This may be sarcasm but maybe not).  Why don't we just
rip out all ide and scsi subsystems and make one general layer that both
physical ide and scsi systems share?

NOTE: I do not have any dealings with the code aspect of IDE and SCSI so I
don't know what would be involed (I don't see it happening anyway).

I've never been a fan of IDE, I dislike it completely.  I'd prefer to simply
buy an ide-scsi hardware converter and make all my drives scsi.  But that's
just me =)

I did find it funny that an IDE drive in a USB box is a SCSI drive under
linux.

Send flames to /dev/null not to the list, I don't want a flame war over
this.  I will not respond to any flames.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
