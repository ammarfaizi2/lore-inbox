Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030478AbWJ3P00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbWJ3P00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbWJ3P00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:26:26 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:36621 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1030478AbWJ3P0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:26:25 -0500
Message-ID: <45461977.3020201@shadowen.org>
Date: Mon, 30 Oct 2006 15:25:43 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Martin Bligh <mbligh@google.com>,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
References: <20061029160002.29bb2ea1.akpm@osdl.org>
In-Reply-To: <20061029160002.29bb2ea1.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc3/2.6.19-rc3-mm1/
> 
> - ia64 doesn't compile due to improvements in acpi.  I already fixed a huge
>   string of build errors due to this and it's someone else's turn.
> 
> - For some reason Greg has resurrected the patches which detect whether
>   you're using old versions of udev and if so, punish you for it.
> 
>   If weird stuff happens, try upgrading udev.

I have four machines showing problems with 2.6.19-rc3-mm1.  In each case
they appear to have lost their ethernet cards completely.  I have a
ppc64 using ibm_veth, two ppc64's using e1000's and an x86_64 using a
Tigon 3.

Before I had results from the non e1000 machines I did try backing out
all e1000 patches to no effect.  I also had a quick scan of the
changelogs for net/ and nothing jumped out at me.

Any suggestions what to hack out next?

-apw
