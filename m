Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbSKMWye>; Wed, 13 Nov 2002 17:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264622AbSKMWye>; Wed, 13 Nov 2002 17:54:34 -0500
Received: from kim.it.uu.se ([130.238.12.178]:27604 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S263977AbSKMWye>;
	Wed, 13 Nov 2002 17:54:34 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15826.55743.478461.458111@kim.it.uu.se>
Date: Thu, 14 Nov 2002 00:01:19 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: local APIC may cause XFree86 hang
In-Reply-To: <1037229569.11996.205.camel@irongate.swansea.linux.org.uk>
References: <15826.53818.621879.661253@kim.it.uu.se>
	<1037229569.11996.205.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > On Wed, 2002-11-13 at 22:29, Mikael Pettersson wrote:
 > > Does XFree86 (its core or particular drivers) use vm86() to
 > > invoke, possibly graphics card specific, BIOS code?
 > > That would explain the hangs I got. The fix would be to
 > > disable the local APIC around vm86()'s BIOS calls, just like
 > > we now disable it before APM suspend.
 > 
 > It does yes

Ok. I'll start working on a patch to vm86() tomorrow.

/Mikael
