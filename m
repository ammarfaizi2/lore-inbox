Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbTLMWJy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 17:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbTLMWJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 17:09:54 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:41882
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S263060AbTLMWJw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 17:09:52 -0500
Date: Sat, 13 Dec 2003 17:18:00 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 and IDE "geometry"
Message-ID: <20031213171800.A28547@animx.eu.org>
References: <20031212131704.A26577@animx.eu.org> <20031212194439.GB11215@win.tue.nl> <20031212163545.A26866@animx.eu.org> <20031213132208.GA11523@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20031213132208.GA11523@win.tue.nl>; from Andries Brouwer on Sat, Dec 13, 2003 at 02:22:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This I know, however, the kernel in the past has the geometry from the BIOS
> 
> The kernel made some attempts. It often worked and often failed.

On all the different PCs I've worked with, it always worked.  Most of those
were dells and old FIC boards.

> > I realize this too, however, I need it to happen automatically and be
> > consistent with the bios idea of the disk.
> 
> So you script sfdisk or so in order to setup large numbers of disks
> and cannot use constant geometry settings because this is on many
> different BIOSes that disagree on the desired geometry?

Not quite, each is 1 PC and 1 Hard disk.

> And this is all on disks smaller than 8 GB so that at least there can be
> some geometry?

Thus far, the smallest has been 1.2gb and the largest being 80gb.  2.4.x (x
= any version upto 21  I have not used 22 or 23 yet) has worked for me
flawlessly.

The script does use sfdisk to aquire the size and the user tells it just how
large the partition to be and defaulting to the largest possible.  If the
geometry is wrong, the other OS won't boot.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
