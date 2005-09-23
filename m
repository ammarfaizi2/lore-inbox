Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbVIWRUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVIWRUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbVIWRUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:20:14 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:41150 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750829AbVIWRUM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:20:12 -0400
Date: Fri, 23 Sep 2005 10:20:14 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Sean Bruno <sean.bruno@dsl-only.net>
Cc: karim@opersys.com, ak@suse.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: The system works (2.6.14-rc2): functional k8n-dl
Message-ID: <20050923172014.GH5910@us.ibm.com>
References: <20050922155254.GE5910@us.ibm.com> <43332254.1040603@opersys.com> <1127495296.25701.15.camel@oscar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127495296.25701.15.camel@oscar>
X-Operating-System: Linux 2.6.14-rc2 (x86_64)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.2005 [10:08:16 -0700], Sean Bruno wrote:
> On Thu, 2005-09-22 at 17:29 -0400, Karim Yaghmour wrote:
> > Nish,
> > 
> > OK, I can confirm that with version 1006 of the BIOS it works flawlessly
> > with Linux. I was able to install full FC4 and boot without a problem
> > even with the SATA disk plugged to the nVidia controller (reading the
> > archives you will see that the nVidia SATA controller is something I
> > was simply unable to get working.) I didn't need to recompile anything.
> > The kernel that came with FC4 worked just fine.
> I can also confirm these findings.  However, I still have to boot the
> kernel with iommu=memaper=3 in order to get the system to work
> properly.  

You have 6GB of RAM, right? That must be the difference, as I only have
2 GB (and the IOMMU is used when you have more than 3 GB according to
menuconfig?).

Regardless, a better state now, I think?

Thanks,
Nish
