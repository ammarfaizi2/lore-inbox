Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272465AbTGZL72 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 07:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272466AbTGZL72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 07:59:28 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:14023 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272465AbTGZL71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 07:59:27 -0400
Date: Sat, 26 Jul 2003 14:14:32 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: some kernel config menu suggested tweaks
Message-ID: <20030726121432.GB6560@louise.pinerecords.com>
References: <Pine.LNX.4.53.0307241256430.20528@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307241256430.20528@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [rpjday@mindspring.com]
> 
> 1) i mentioned this before, i think, but after one deselects
>    Power management, should ACPI Support and CPU Frequency
>    scaling still be available?
> 
>    the "make xconfig" menu display suggests a submenu 
>    structure there, which clearly isn't the case.

Why don't you go ahead and send a patch?

> 2) can all of the low-level SCSI drivers be made deselectable
>    in one swell foop?  folks might want SCSI support just for
>    generic support and SCSI (ide-scsi) emulation, but have no
>    interest in low level SCSI drivers.

Add a SCSI lowlevel drivers submenu (~4 lines of Kconfig).

> 3) can all of ATM support be deselected with a single click?
>    in the same way "PCMCIA network device support" is done just
>    above it under "Networking options"?

Send a patch.

-- 
Tomas Szepe <szepe@pinerecords.com>
