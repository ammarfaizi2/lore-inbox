Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263533AbTJLUo4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 16:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263534AbTJLUo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 16:44:56 -0400
Received: from gprs149-193.eurotel.cz ([160.218.149.193]:27777 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263533AbTJLUoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 16:44:55 -0400
Date: Sun, 12 Oct 2003 22:44:39 +0200
From: Pavel Machek <pavel@suse.cz>
To: Marshal Newrock <marshal@simons-rock.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test7: suspend to disk: no mouse or sound after suspend
Message-ID: <20031012204439.GC664@elf.ucw.cz>
References: <Pine.LNX.4.58.0310111304410.14916@minerva.simons-rock.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0310111304410.14916@minerva.simons-rock.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> (Please cc: me on all replies)
> 
> Using Gentoo (stable) with kernel 2.6.0-test7.  I had tried Software
> Suspend, but 'echo 4 > /proc/acpi/sleep' did not put the computer to
> sleep, so I am using Suspend-to-Disk.  The computer goes through the

Eh? So what are you doing to make it sleep.

Aha, pmdisk.

> shutdown, but hits an oops.  On rebooting, the state of the computer is
> restored, but my USB optical mouse remains unpowered.

Well, seems you have driver problems. Your help is likely needed with
es1371 driver.
								Pavel

> Other systems tested:
> Sound (ALSA, es1371 built-in), no output after suspend.
> PC Speaker (module) works.
> Networking (rtl8139 built-in) works.
> IDE CD-ROM (module) works.
> SCSI (sym53c8xx module) works.

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
