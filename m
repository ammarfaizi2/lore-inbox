Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSHAQIm>; Thu, 1 Aug 2002 12:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315628AbSHAQIl>; Thu, 1 Aug 2002 12:08:41 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:37104 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315607AbSHAQIl>; Thu, 1 Aug 2002 12:08:41 -0400
Subject: Re: [patch] vm86: Clear AC on INT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: root@chaos.analogic.com, stas.orel@mailcity.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D4959EF.15022EE8@daimi.au.dk>
References: <Pine.LNX.3.95.1020801105021.26692A-100000@chaos.analogic.com>
	<1028220750.15022.67.camel@irongate.swansea.linux.org.uk> 
	<3D4959EF.15022EE8@daimi.au.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 18:28:20 +0100
Message-Id: <1028222900.14871.77.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 16:55, Kasper Dupont wrote:
> This would be similar to the use of the use of the VIF flag to
> emulate the IF flag. This flag has actually got me wondering:
> AFAIR the flag is mentioned in Intel specs, but it looks like
> in Linux the flag is implemented 100% in software with no help
> from the CPU. Is that correct, or did I miss something?

The kernel itself doesn't use the alignment flags but some applications
do. For example some language systems use alignment traps for
typechecking by adding a type code (0-3) to the address and
dereferencing it

