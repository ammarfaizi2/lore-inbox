Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbSJZO4X>; Sat, 26 Oct 2002 10:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbSJZO4X>; Sat, 26 Oct 2002 10:56:23 -0400
Received: from franka.aracnet.com ([216.99.193.44]:34270 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262201AbSJZO4W>; Sat, 26 Oct 2002 10:56:22 -0400
Date: Sat, 26 Oct 2002 08:00:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@redhat.com>, Dave Jones <davej@codemonkey.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Double x86 initialise fix.
Message-ID: <3007712682.1035619204@[10.10.2.3]>
In-Reply-To: <200210261357.g9QDvgl13774@devserv.devel.redhat.com>
References: <200210261357.g9QDvgl13774@devserv.devel.redhat.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Isn't this always the case on x86 ?
>> /me waits to hear gory details of some IBM monster.
> 
> It isnt. The boot CPU may be any number. In addition you can strap dual
> pentium boxes to arbitrate for who is boot cpu (this is used for fault
> tolerance).

Eh? I don't understand this, and I think Dave is right for all the
IBM monsters I know of ;-) The *apicid* may not be 0 but the CPU
numbers are dynamically assigned as we boot, so the boot CPU will
always get 0, surely?

M.

