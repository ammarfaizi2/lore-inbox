Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSHAQSv>; Thu, 1 Aug 2002 12:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315358AbSHAQSv>; Thu, 1 Aug 2002 12:18:51 -0400
Received: from daimi.au.dk ([130.225.16.1]:6293 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S315222AbSHAQSv>;
	Thu, 1 Aug 2002 12:18:51 -0400
Message-ID: <3D496019.88237C6@daimi.au.dk>
Date: Thu, 01 Aug 2002 18:21:45 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: root@chaos.analogic.com, stas.orel@mailcity.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] vm86: Clear AC on INT
References: <Pine.LNX.3.95.1020801105021.26692A-100000@chaos.analogic.com>
		<1028220750.15022.67.camel@irongate.swansea.linux.org.uk> 
		<3D4959EF.15022EE8@daimi.au.dk> <1028222900.14871.77.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Thu, 2002-08-01 at 16:55, Kasper Dupont wrote:
> > This would be similar to the use of the use of the VIF flag to
> > emulate the IF flag. This flag has actually got me wondering:
> > AFAIR the flag is mentioned in Intel specs, but it looks like
> > in Linux the flag is implemented 100% in software with no help
> > from the CPU. Is that correct, or did I miss something?
> 
> The kernel itself doesn't use the alignment flags but some applications
> do. For example some language systems use alignment traps for
> typechecking by adding a type code (0-3) to the address and
> dereferencing it

Ehrm, that wasn't my point. My point was that if the feature exist
in virtual 86 mode but not in real mode, the kernel should prevent
it from being used in virtual 86 mode because it is supposed to
emulate real mode.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
