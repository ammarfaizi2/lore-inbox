Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262757AbSI1JYw>; Sat, 28 Sep 2002 05:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262758AbSI1JYw>; Sat, 28 Sep 2002 05:24:52 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:11259 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262757AbSI1JYv>; Sat, 28 Sep 2002 05:24:51 -0400
Subject: Re: Does kernel use system stdarg.h?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Oliver Xymoron <oxymoron@waste.org>, Daniel Jacobowitz <dan@debian.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020928091530.B32639@flint.arm.linux.org.uk>
References: <20020927140543.GA5613@nevyn.them.org>
	<20020927214721.GK21969@waste.org> 
	<20020928091530.B32639@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Sep 2002 10:34:35 +0100
Message-Id: <1033205675.17717.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-28 at 09:15, Russell King wrote:
> It certainly looks like it.  gcc 3.0.3 appears to ignore
> "-iwithprefix include", where as gcc 2.95.x, 2.96, 3.1 and 3.2 all
> work as expected.

Thats ok. For x86 at least using 3.0.x isnt wise (it occasionally spills
data below the stack pointer which means an IRQ at the wrong moment has
dire consequences)

