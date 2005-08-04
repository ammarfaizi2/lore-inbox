Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262688AbVHDVE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbVHDVE3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbVHDVES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:04:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59018 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262688AbVHDVDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:03:10 -0400
Date: Thu, 4 Aug 2005 14:04:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sebastian Kaergel <mailing@wodkahexe.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: Linux v2.6.13-rc3
Message-Id: <20050804140459.2ffd4bd3.akpm@osdl.org>
In-Reply-To: <20050714001843.3c14d071.mailing@wodkahexe.de>
References: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org>
	<20050714001843.3c14d071.mailing@wodkahexe.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Kaergel <mailing@wodkahexe.de> wrote:
>
> On Tue, 12 Jul 2005 22:05:00 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > Dmitry Torokhov:
> >   [ACPI] Enable EC Burst Mode
> 
> After booting 2.6.13-rc3 on my acer travlemate 291LCI it starts
> complaining:
> 
>  acpi_ec-0217 [30] acpi_ec_leave_burst_mo: ------->status fail
>  acpi_ec-0217 [30] acpi_ec_leave_burst_mo: ------->status fail
> 
> 2.6.13-rc{1,2} did not have this problem.

We reverted the ec burst mode changes.  I'll assume that 2.6.13-rc6 fixes
this up for you.  If not, or if problems remain, please let us know. 
Preferably via bugzilla.kernel.org, thanks.

