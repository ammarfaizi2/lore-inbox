Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266641AbSIRNuQ>; Wed, 18 Sep 2002 09:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266646AbSIRNuQ>; Wed, 18 Sep 2002 09:50:16 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:49403
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266641AbSIRNuQ> convert rfc822-to-8bit; Wed, 18 Sep 2002 09:50:16 -0400
Subject: Re: Which processor/board for embedded NTP
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olaf =?iso-8859-2?Q?Fr=B1czyk?= <olaf@cbk.poznan.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1032354632.23252.14.camel@venus>
References: <1032354632.23252.14.camel@venus>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Sep 2002 14:58:32 +0100
Message-Id: <1032357512.20402.96.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-18 at 14:10, Olaf Fr±czyk wrote:
> I have to build NTP server on an embedded pc.
> Which processors/boards are suitable for this.
> Such processor/board cannot have ANY problems with time handling.

Game over. There is no PC technology that doesn't have some problems
with time handling 8)

> I thought about Geode (NS), but I found some info that it doesn't have
> TSC, or it works not properly (the PPS needs TSC). 
> And of course has to work excellent with linux.

The Geode aka Cyrix MediaGx TSC problems are not in the TSC but in the
PIT emulation in the chipset. That problem isnt present on the 5530 and
later chipsets. So its a long buried problem. You might also want to
look at the VIA Eden based boards if its got to be embedded (fanless
550MHz)

