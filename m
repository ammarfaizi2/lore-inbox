Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVDDVul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVDDVul (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVDDVuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:50:40 -0400
Received: from hammer.engin.umich.edu ([141.213.40.79]:61087 "EHLO
	hammer.engin.umich.edu") by vger.kernel.org with ESMTP
	id S261411AbVDDVmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:42:38 -0400
Date: Mon, 4 Apr 2005 17:42:34 -0400 (EDT)
From: Christopher Allen Wing <wingc@engin.umich.edu>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: clock runs at double speed on x86_64 system w/ATI RS200 chipset
In-Reply-To: <16977.24079.564977.842269@alkaid.it.uu.se>
Message-ID: <Pine.LNX.4.58.0504041735360.32159@hammer.engin.umich.edu>
References: <200504031231.j33CVtHp021214@harpo.it.uu.se>
 <Pine.LNX.4.58.0504041050250.32159@hammer.engin.umich.edu>
 <16977.24079.564977.842269@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Apr 2005, Mikael Pettersson wrote:

> In principle ACPI shouldn't be needed, but in its absence the
> BIOS must provide an MP table and the x86-64 kernel must still
> have code to parse it -- otherwise I/O APIC mode won't work.
> I don't know if that's the case or not.

Thanks. What I meant is that I thought distributions are enabling ACPI by
default because the mptable is likely to be broken.

> I suggest you boot normally (with ACPI fully enabled) and send a
> bug report to LKML and the ACPI list with the interrupt routing
> info from the kernel log.

I entered a bug report under ACPI on the kernel bugzilla:

	http://bugme.osdl.org/show_bug.cgi?id=4442

containing the relevant information. It looks like booting with 'noapic'
on the command line will be an acceptable workaround for now.


Thanks,

Chris
wingc@engin.umich.edu
