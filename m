Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSHAQ1j>; Thu, 1 Aug 2002 12:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSHAQ1j>; Thu, 1 Aug 2002 12:27:39 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:62704 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315717AbSHAQ1i>; Thu, 1 Aug 2002 12:27:38 -0400
Subject: Re: [patch] vm86: Clear AC on INT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: root@chaos.analogic.com, stas.orel@mailcity.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D496019.88237C6@daimi.au.dk>
References: <Pine.LNX.3.95.1020801105021.26692A-100000@chaos.analogic.com>
	<1028220750.15022.67.camel@irongate.swansea.linux.org.uk> 
	<3D4959EF.15022EE8@daimi.au.dk>
	<1028222900.14871.77.camel@irongate.swansea.linux.org.uk> 
	<3D496019.88237C6@daimi.au.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 18:47:16 +0100
Message-Id: <1028224036.14871.83.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 17:21, Kasper Dupont wrote:
> Ehrm, that wasn't my point. My point was that if the feature exist
> in virtual 86 mode but not in real mode, the kernel should prevent
> it from being used in virtual 86 mode because it is supposed to
> emulate real mode.

That would prevent people wanting to run real virtualised 8086 stuff
that does use the AC trap, and other vm86 extensions to the basic real
mode stuff.

If you want an accurate real mode emulation you are stuck with Bochs,
not down to the kernel but down to the fact vm86 is a mode for running
8086 applications under a 32bit system, not a mode for emulation of real
mode.


