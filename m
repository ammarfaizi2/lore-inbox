Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316205AbSEKD2Q>; Fri, 10 May 2002 23:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316206AbSEKD2P>; Fri, 10 May 2002 23:28:15 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:52998 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316205AbSEKD2P>;
	Fri, 10 May 2002 23:28:15 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iget-locked [2/6] 
In-Reply-To: Your message of "Fri, 10 May 2002 22:06:46 EST."
             <Pine.LNX.4.44.0205102204040.11642-100000@chaos.physics.uiowa.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 May 2002 13:28:04 +1000
Message-ID: <4362.1021087684@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002 22:06:46 -0500 (CDT), 
Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
>On Sat, 11 May 2002, Keith Owens wrote:
>
>> True, but if the iget change goes into 2.5 it will probably be
>> backported to 2.4 later, 2.4 still has the restriction.
>
>It's a two line change to Rules.make, so I suppose that can be backported
>as well ;-) 

The change looks safe enough for the kernel but I worry about its
impact on distributors who play silly buggers with the modversion
files (R**H** springs to mind).  It would be polite to check with the
major distributors before backporting the change to 2.4.

>It's needed anyway IIRC, since s390 and ISDN both have fsm.o, and both do
>export symbols.

ISDN on s390.  The mind boggles.

