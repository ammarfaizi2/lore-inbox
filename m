Return-Path: <linux-kernel-owner+w=401wt.eu-S1754436AbWLYVOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436AbWLYVOr (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 16:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754499AbWLYVOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 16:14:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51880 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754436AbWLYVOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 16:14:47 -0500
Date: Mon, 25 Dec 2006 22:14:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Mobily <merc@mobily.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Putting the sdhci to sleep safely [with attachments]
Message-ID: <20061225211432.GA2460@elf.ucw.cz>
References: <458FA64E.7070501@mobily.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458FA64E.7070501@mobily.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

(Please always cc: linux-kernel@ with such stuff).

> I am the Editor In Chief of Free Software Magazine
> (http://www.freesoftwaremagazine.com)
> I am in a bit of a mission: I would like to see the module sdhci put my
> card reader to sleep without getting the system highly
> unstable. This is

Well, suspend works for me, and my machine seems to have sdhci:

0000:15:00.2 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host
Adapter (rev 18)

> Pierre Ossman, the maintainer of the sdhci module, wrote to me:
> 
> "Anyway, as far as I know, this isn't a bug in the driver, so there is
> not very much I can do. The problem is somewhere in the PCI interaction,
> but I've sent numerous mail to the kernel PCI hackers, but have yet to
> receive a single reply."

I've certainly not seen such a mail. Can you get info what is wrong
with that, and cc lkml, me and greg?

> This is why I felt there was no point for me to file a big report...

> So, here I am... please find attache my lspci and the log of what
> happens when the computer is put to sleep.
> 
> I would also be happy to organise a bounty for this bug to be fixed.

:-). Just hunt it yourself. It is probably easier than organizing a bounty.

Ouch... you failed to mention what kernel you are using?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
