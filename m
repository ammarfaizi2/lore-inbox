Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbSIZVbq>; Thu, 26 Sep 2002 17:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261535AbSIZVbq>; Thu, 26 Sep 2002 17:31:46 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:35310
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261523AbSIZVap>; Thu, 26 Sep 2002 17:30:45 -0400
Subject: Re: Distributing drivers independent of the kernel source tree
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: "Heater, Daniel (IndSys, " "GEFanuc, VMIC)" 
	<Daniel.Heater@gefanuc.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
In-Reply-To: <1033074519.2698.5.camel@localhost.localdomain>
References: <A9713061F01AD411B0F700D0B746CA6802FC14D6@vacho6misge.cho.ge.com> 
	<1033074519.2698.5.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Sep 2002 22:41:02 +0100
Message-Id: <1033076462.1269.196.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-26 at 22:08, Arjan van de Ven wrote:
> you have to use
> 
> /lib/modules/`uname -r`/build
> (yes it's a symlink usually, but that doesn't matter)
> 
> 
> that's what Linus decreed and that's what all distributions honor, and
> that's that make install does for manual builds.

One additional item that may be useful, for Red Hat at least there is a
little kit to build additional driver disks.

