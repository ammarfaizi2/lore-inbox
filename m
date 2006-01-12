Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWALRbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWALRbF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWALRbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:31:05 -0500
Received: from [81.2.110.250] ([81.2.110.250]:33938 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932280AbWALRbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:31:02 -0500
Subject: Re: Help with machine check exception
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Orion Poplawski <orion@cora.nwra.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <dq62df$gse$1@sea.gmane.org>
References: <dq606p$776$1@sea.gmane.org>  <dq62df$gse$1@sea.gmane.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Jan 2006 17:33:53 +0000
Message-Id: <1137087233.26334.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-12 at 10:07 -0700, Orion Poplawski wrote:
> mcelog decode states:
> 
> CPU 0 4 northbridge TSC 184fcd0553e4
>    Northbridge Watchdog error
>         bit57 = processor context corrupt
>         bit61 = error uncorrected
>    bus error 'generic participation, request timed out
>        generic error mem transaction
>        generic access, level generic'
> STATUS b200000000070f0f MCGSTATUS 4
> Kernel panic - not syncing: Machine check

Could be ram cpu or motherboard, even a power glitch of course.

Before you panic I'd suggest that you check the machine is being
adequately cooled (especially the CPU) and that the ram and cpu are all
well socketed.

memtest86+ will help test for memory problems and may be worth an
overnight run

