Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263270AbSKMWrp>; Wed, 13 Nov 2002 17:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262924AbSKMWro>; Wed, 13 Nov 2002 17:47:44 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:4011 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262881AbSKMWrn>; Wed, 13 Nov 2002 17:47:43 -0500
Subject: Re: local APIC may cause XFree86 hang
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <15826.53818.621879.661253@kim.it.uu.se>
References: <15826.53818.621879.661253@kim.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 23:19:29 +0000
Message-Id: <1037229569.11996.205.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-13 at 22:29, Mikael Pettersson wrote:
> Does XFree86 (its core or particular drivers) use vm86() to
> invoke, possibly graphics card specific, BIOS code?
> That would explain the hangs I got. The fix would be to
> disable the local APIC around vm86()'s BIOS calls, just like
> we now disable it before APM suspend.

It does yes

