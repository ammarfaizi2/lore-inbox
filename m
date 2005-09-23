Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVIWRQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVIWRQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVIWRQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:16:48 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:44464 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750823AbVIWRQs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:16:48 -0400
Date: Fri, 23 Sep 2005 10:16:49 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: sean.bruno@dsl-only.net, ak@suse.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: The system works (2.6.14-rc2): functional k8n-dl
Message-ID: <20050923171649.GG5910@us.ibm.com>
References: <20050922155254.GE5910@us.ibm.com> <43332254.1040603@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43332254.1040603@opersys.com>
X-Operating-System: Linux 2.6.14-rc2 (x86_64)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.2005 [17:29:56 -0400], Karim Yaghmour wrote:
> 
> Nish,
> 
> OK, I can confirm that with version 1006 of the BIOS it works flawlessly
> with Linux. I was able to install full FC4 and boot without a problem
> even with the SATA disk plugged to the nVidia controller (reading the
> archives you will see that the nVidia SATA controller is something I
> was simply unable to get working.) I didn't need to recompile anything.
> The kernel that came with FC4 worked just fine.

Great!

> This is great news. That box had been sitting on my rack for the past
> couple of months because I was just not able to get Linux to work
> properly. I had figured I would put a cheap network card in there just
> to get things started, but it really wasn't doing what I bought it
> for. Now it works as would be expected.

That's actually why I bothered sending out a report. I had *no* problems
booting with "noapic nolapic pci=noacpi" with BIOS revisions 1003 and
1004. When I saw that both you and Sean had problems, I figured I would
let you know what progress I was making.

> Hopefully next time ASUS releases a board they actually test that it
> works with all major OSes before making the release. In this case, I
> feel as if I was tricked into buying a board that really didn't perform
> as planned, and as a result I wasted lots of time which could been for
> more productive work.

Again, I find it odd that it worked OOB for me (with the aforementioned
boot params).

Regardless, I'm glad it is working for you now.

Thanks,
Nish
