Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317430AbSHHLH0>; Thu, 8 Aug 2002 07:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317446AbSHHLH0>; Thu, 8 Aug 2002 07:07:26 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:38638 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317430AbSHHLHZ>; Thu, 8 Aug 2002 07:07:25 -0400
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin@dalecki.de
Cc: Ingo Molnar <mingo@elte.hu>, "Adam J. Richter" <adam@yggdrasil.com>,
       Andries.Brouwer@cwi.nl, johninsd@san.rr.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D523B25.5080105@evision.ag>
References: <Pine.LNX.4.44.0208081129420.3210-100000@localhost.localdomain>
	 <3D523B25.5080105@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 08 Aug 2002 13:30:30 +0100
Message-Id: <1028809830.28883.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 10:34, Marcin Dalecki wrote:
> >   [mingo@a mingo]$ ls -l /sbin/lilo
> >   -rwxr-xr-x    1 root     root        59324 Aug 23  2000 /sbin/lilo
> 
> Yes sure. It is simply a very old bug in lilo, which the kernel worked
> around and did fight against in a diallectic way.

Its not a bug in lilo. Its a bug in the new kernel. Breaking backward
compatibility arbitarily is bad. The kernel needs to know geometry
anyway for the folks who have force ide translation

