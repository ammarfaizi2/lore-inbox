Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269670AbTGXSUq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 14:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269671AbTGXSUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 14:20:46 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:16512 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S269670AbTGXSUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 14:20:45 -0400
Date: Thu, 24 Jul 2003 19:45:54 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307241845.h6OIjsYD000632@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org, rpjday@mindspring.com
Subject: Re: some kernel config menu suggested tweaks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) i mentioned this before, i think, but after one deselects
>    Power management, should ACPI Support and CPU Frequency
>    scaling still be available?
>
>    the "make xconfig" menu display suggests a submenu 
>    structure there, which clearly isn't the case.
>
>
> 2) can all of the low-level SCSI drivers be made deselectable
>    in one swell foop?  folks might want SCSI support just for
>    generic support and SCSI (ide-scsi) emulation, but have no
>    interest in low level SCSI drivers.
>
>    so it would be convenient to be able to select the generic
>    support, and yet not have to deselect low-level drivers
>    and PCMCIA SCSI adapter support painfully, one at a time.
>
> 3) can all of ATM support be deselected with a single click?
>    in the same way "PCMCIA network device support" is done just
>    above it under "Networking options"?

A lot of these add extra complications for anybody not wanting a
'simple' kernel config.  _Please_ don't re-design everything the same
way as the once-simple filesystems menu.

Too much prompting is irritating for advanced users, and they are the
people who are likely to compiling the most kernels, rather than
sticking with the kernel that came with their distribution.

John.
