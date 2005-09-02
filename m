Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVIBSEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVIBSEn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 14:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVIBSEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 14:04:43 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:13254 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1750753AbVIBSEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 14:04:43 -0400
To: Molle Bestefich <molle.bestefich@gmail.com>
Subject: Re: IDE HPA
Cc: ataraid-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <62b0912f05090210441d3fa248@mail.gmail.com>
References: <87941b4c05082913101e15ddda@mail.gmail.com> <87941b4c05083008523cddbb2a@mail.gmail.com> <1125419927.8276.32.camel@localhost.localdomain> <87941b4c050830095111bf484e@mail.gmail.com> <62b0912f0509020027212e6c42@mail.gmail.com> <1125666332.30867.10.camel@localhost.localdomain> <62b0912f05090206331d04afd3@mail.gmail.com> <E1EBCdS-00064p-00@chiark.greenend.org.uk> <62b0912f05090209242ad72321@mail.gmail.com> <1125680712.30867.20.camel@localhost.localdomain> <1125680712.30867.20.camel@localhost.localdomain> <62b0912f05090210441d3fa248@mail.gmail.com>
Date: Fri, 2 Sep 2005 19:04:40 +0100
Message-Id: <E1EBFu4-0005Xr-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Molle Bestefich <molle.bestefich@gmail.com> wrote:

> The other way round, users would have to google to find the kernel
> option that claims the HPA area (if they felt the need to overwrite
> the BIOS's backup area), but those that felt the need would then be
> rewarded with eg. 10 GB extra disk space.  And if they didn't feel
> like it, their userspace apps would still work just fine.

Unless they already have a filesystem that stretches over the HPA, in
which case the change in default behaviour would result in kernel
upgrades breaking everything horribly. It may well be the case that the
current situation is undesirable, but just changing it back *will break*
things.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
