Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSGNAin>; Sat, 13 Jul 2002 20:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSGNAim>; Sat, 13 Jul 2002 20:38:42 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:32241 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315485AbSGNAil>; Sat, 13 Jul 2002 20:38:41 -0400
Subject: Re: Linux 2.4.19-rc1-ac3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Osterlund <petero2@telia.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <m265zj9zxn.fsf@best.localdomain>
References: <Pine.LNX.4.44.0207131435570.3808-100000@linux-box.realnet.co.sz>
	<m2n0svr42e.fsf@best.localdomain>
	<1026584861.13886.27.camel@irongate.swansea.linux.org.uk> 
	<m265zj9zxn.fsf@best.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 Jul 2002 02:50:37 +0100
Message-Id: <1026611437.13885.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 20:43, Peter Osterlund wrote:
> 1. apm idle mode consumes less power at lower frequencies

CPU halting makes a difference on older cpus but not really on modern
ones
.
> 2. The lower clock frequency means less work gets done, for example
>    because window updates become less frequent when moving windows.

Your CPU has a clock range, zero is not in that range. If you can
complete all your work within an acceptable time slice (based on
previous task histories) there is no need to run full on.

> 3. The cpu voltage is automatically reduced when the frequency is
>    reduced.

True for some x86 processors, either automatically, or on some
controlled by us.


