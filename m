Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbUCBUIL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 15:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbUCBUIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 15:08:11 -0500
Received: from dirac.phys.uwm.edu ([129.89.57.19]:5259 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S261758AbUCBUIE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 15:08:04 -0500
Date: Tue, 2 Mar 2004 14:07:55 -0600 (CST)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Nico Schottelius <nico-kernel@schottelius.org>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Bruce Allen <ballen@gravity.phys.uwm.edu>, linux-kernel@vger.kernel.org
Subject: Re: harddisk or kernel problem?
In-Reply-To: <20040219080115.GD25184@schottelius.org>
Message-ID: <Pine.GSO.4.21.0403021405220.21720-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico,

> > [...] 
> > FWIW, after reading this thread, I've slightly modified smartmontools so
> > that when smartctl prints the error log (-l error) it ALSO prints the LBA
> > at which a READ or WRITE command failed.
> 
> Thank you very much for patching smartctl and explaining howto calulate
> the LBA from those values.

FWIW, I've just posted a short howto explaining how to identify the file
stored at the bad sector, and how to force sector reallocation at the bad
LBA.  This will effectively 'repair' the disk though you will lose the
data in that disk block.  Please see:

http://smartmontools.sourceforge.net/BadBlockHowTo.txt

Comments gratefully incorporated.

Cheers,
	Bruce

