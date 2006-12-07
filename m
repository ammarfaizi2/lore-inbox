Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163241AbWLGTy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163241AbWLGTy0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 14:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163244AbWLGTy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 14:54:26 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:4409 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1163241AbWLGTyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 14:54:25 -0500
Date: Thu, 7 Dec 2006 20:54:20 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>, Daniel Drake <dsd@gentoo.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linus Torvalds <torvalds@osdl.org>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: RFC: PCI quirks update for 2.6.16
Message-Id: <20061207205420.15622d52.khali@linux-fr.org>
In-Reply-To: <20061207132430.GF8963@stusta.de>
References: <20061207132430.GF8963@stusta.de>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Thu, 7 Dec 2006 14:24:30 +0100, Adrian Bunk wrote:
> While checking how to fix the VIA quirk regressions for several users 
> introduced into -stable in 2.6.16.17, I started looking through all 
> drivers/pci/quirks.c updates up to both -stable and 2.6.19.
> 
> Below is the selection the seemed good and safe.
> 
> Any comments on whether it's really good or whether I should change 
> anything?
> (...)
> Jean Delvare (1):
>       PCI: Unhide the SMBus on Asus PU-DLS

Should be safe.

> Tomasz Koprowski (1):
>       PCI: SMBus unhide on HP Compaq nx6110

Bug #6944 might be related to this one, so I'd not include it in
2.6.16-stable.

-- 
Jean Delvare
