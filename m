Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbSKXXfk>; Sun, 24 Nov 2002 18:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSKXXfk>; Sun, 24 Nov 2002 18:35:40 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:8845 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261963AbSKXXfj>; Sun, 24 Nov 2002 18:35:39 -0500
Subject: Re: enabling AMD_PM768 causes boot hang in 2.4.20-rc3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bruce Lowekamp <lowekamp@CS.WM.EDU>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <6320000.1038078904@localhost.localdomain>
References: <6320000.1038078904@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Nov 2002 00:13:00 +0000
Message-Id: <1038183180.28491.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-23 at 19:15, Bruce Lowekamp wrote:
> 
> With a dual-processor A7M266-D MB (two AMD XP-MP 1900+), enabling 
> CONFIG_AMD_PM768 causes the machine to hang on boot.
> 
> I don't think this is a major concern for the release because the 
> description of this parameter includes EXPERIMENTAL (although it is not 
> flagged to be selectable on when experimental options are enabled).
> 
> A few details:  The kernel is booted with noapic (has always hung 
> otherwise).  It hangs right after listing the drives and ide interfaces, 
> and right before it prints out the geometry of the first drive.  This is 
> the output prior to hanging:

Does it work loaded as a module ?

