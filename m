Return-Path: <linux-kernel-owner+w=401wt.eu-S1761214AbWLHVKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761214AbWLHVKe (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 16:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761217AbWLHVKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 16:10:34 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:50089 "EHLO
	myri.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761214AbWLHVKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 16:10:33 -0500
Message-ID: <4579D2E3.2080304@myri.com>
Date: Fri, 08 Dec 2006 22:02:27 +0100
From: Brice Goglin <brice@myri.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Linus Torvalds <torvalds@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: RFC: PCI quirks update for 2.6.16
References: <20061207132430.GF8963@stusta.de>
In-Reply-To: <20061207132430.GF8963@stusta.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> While checking how to fix the VIA quirk regressions for several users 
> introduced into -stable in 2.6.16.17, I started looking through all 
> drivers/pci/quirks.c updates up to both -stable and 2.6.19.
>
> Below is the selection the seemed good and safe.
>
> Any comments on whether it's really good or whether I should change 
> anything?
>
>
> Brice Goglin (1):
>       PCI: nVidia quirk to make AER PCI-E extended capability visible
>   

No problem with this one (but it won't be very useful since nobody used
the PCIe AER cap before myri10ge in 2.6.18 IIRC).

Thanks.
Brice

