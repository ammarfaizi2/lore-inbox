Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbUC0Wt0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 17:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbUC0Wt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 17:49:26 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:12161
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S261906AbUC0WtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 17:49:25 -0500
Date: Sat, 27 Mar 2004 18:00:18 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't eject jaz disk on 2.6
Message-ID: <20040327180018.A4269@animx.eu.org>
References: <20040327075918.A2232@animx.eu.org> <20040327224222.GA5203@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20040327224222.GA5203@one-eyed-alien.net>; from Matthew Dharm on Sat, Mar 27, 2004 at 02:42:22PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've used 2.6.0 to 2.6.4 on a computer with a jaz drive.
> > Using eject 2.0.13, I'm unable to eject the disk.  I have tested on 2.4.24
> > and it does eject.
> 
> Over on the usb-storage list, we've just become aware of a similar problem.

What was it with?

> Are you using SCSI or IDE?

SCSI.  I thought all JAZ disks were scsi?

> We've actually recorded the SCSI layer sending us a PREVENT_MEDIUM_REMOVAL,
> then a START_STOP (to actually eject), and then an ALLOW_MEDIUM_REMOVAL.
> So, nothing gets ejected.  This is under 2.6.

I have noticed that when I attempt to eject, it spins the disk backup,
spins down and that's it.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
