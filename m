Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266019AbUA1Rbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 12:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266017AbUA1Rbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 12:31:51 -0500
Received: from ns.suse.de ([195.135.220.2]:35797 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266019AbUA1Rbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 12:31:49 -0500
Date: Wed, 28 Jan 2004 18:31:42 +0100
From: Andi Kleen <ak@suse.de>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP AMD64 (Tyan S2882) problems.
Message-Id: <20040128183142.0e5963b7.ak@suse.de>
In-Reply-To: <20040128180702.E6714@fi.muni.cz>
References: <20040127190911.B13769@fi.muni.cz.suse.lists.linux.kernel>
	<p73fze1fdk4.fsf@nielsen.suse.de>
	<20040127224931.D24747@fi.muni.cz>
	<20040128180702.E6714@fi.muni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004 18:07:03 +0100
Jan Kasprzak <kas@informatics.muni.cz> wrote:

> 	With pci=noacpi the system does not boot: it hangs during
> the 3ware initialization - prints the following message:
> 
> 3w-xxxx: scsi0: UNIT #0: Command (000001002645b0) timed out, resetting card
> 3w-xxxx: scsi0: UNIT #0: Command (000001002645b0) timed out, resetting card
> 
> Then it tries the same with UNIT #1 (whatever it is) and then the system
> locks up.
> 
> 	With acpi=off it boots correctly. I will try it in another
> Tyan S2882 box - it may be a faulty mainboard.

It's probably an ACPI bug.  I don't have time to look into it right now though.
You can file a bug in kernel bugzilla so that it isn't forgotten.

-Andi
