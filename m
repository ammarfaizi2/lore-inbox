Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSJZPWR>; Sat, 26 Oct 2002 11:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262214AbSJZPWR>; Sat, 26 Oct 2002 11:22:17 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:30923 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262210AbSJZPWR>; Sat, 26 Oct 2002 11:22:17 -0400
Subject: Re: [PATCH] Double x86 initialise fix.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Alan Cox <alan@redhat.com>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3007712682.1035619204@[10.10.2.3]>
References: <200210261357.g9QDvgl13774@devserv.devel.redhat.com> 
	<3007712682.1035619204@[10.10.2.3]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Oct 2002 16:46:20 +0100
Message-Id: <1035647180.13244.121.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-26 at 16:00, Martin J. Bligh wrote:
> >> Isn't this always the case on x86 ?
> >> /me waits to hear gory details of some IBM monster.
> > 
> > It isnt. The boot CPU may be any number. In addition you can strap dual
> > pentium boxes to arbitrate for who is boot cpu (this is used for fault
> > tolerance).
> 
> Eh? I don't understand this, and I think Dave is right for all the
> IBM monsters I know of ;-) The *apicid* may not be 0 but the CPU
> numbers are dynamically assigned as we boot, so the boot CPU will
> always get 0, surely?

Ok its a logical ID - so yes

