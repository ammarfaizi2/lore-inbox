Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317735AbSFLQYe>; Wed, 12 Jun 2002 12:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317736AbSFLQYe>; Wed, 12 Jun 2002 12:24:34 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:33039 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S317735AbSFLQYd>; Wed, 12 Jun 2002 12:24:33 -0400
Date: Wed, 12 Jun 2002 18:03:25 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: question: i/o port 0x61 on x86 archs
Message-ID: <20020612180325.E22429@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20020608165147.A16911@in.ibm.com> <Pine.LNX.4.33L2.0206081458560.28858-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2002 at 03:01:13PM -0700, Randy Dunlap wrote:
> On Sat, 8 Jun 2002, Ravikiran G Thirumalai wrote:
> | I have a question regdg do_nmi routine in x86; what does location 0x61
> | from inb(0x61) do? Is it something very well known in intel archs?
> Port 0x61 is the NMI status and control register.

So it should exist a '#define' for this somewhere. 

People who tend to disagree here, may try to use *.i files
instead of *.c and *.h files next time.

The IRQ-handling code is full of these beauties and several
drivers are too.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
