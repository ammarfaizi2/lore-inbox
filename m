Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281485AbRKTXWJ>; Tue, 20 Nov 2001 18:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281487AbRKTXV7>; Tue, 20 Nov 2001 18:21:59 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:24581 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S281485AbRKTXVl>;
	Tue, 20 Nov 2001 18:21:41 -0500
Message-Id: <200111202321.fAKNLDeG029104@sleipnir.valparaiso.cl>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Jason Tackaberry <tack@auc.ca>, linux-kernel@vger.kernel.org
Subject: Re: File size limit exceeded with mkfs 
In-Reply-To: Your message of "Tue, 20 Nov 2001 11:33:17 PDT."
             <20011120113316.R1308@lynx.no> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Tue, 20 Nov 2001 20:21:13 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@turbolabs.com> said:
> On Nov 20, 2001  11:02 -0500, Jason Tackaberry wrote:
> > I just installed a shiny new 80GB disk as primary slave and decided to
> > upgrade to 2.4.14+ext3 patch.  It appears that with this kernel, and
> > also with 2.4.15-pre7, when trying to mkfs partitions greater than 2GB,
> > I get "file size limit exceeded" and mkfs aborts.  I can successfully
> > mkfs partitions <= 2GB.
> > 
> > I do not have this problem with 2.4.7; all works well.  Wondering if the
> > difference was ext3, I tried compiling 2.4.15-pre7 without ext3 support
> > and the same problem occured.
> 
> Several people have reported problems like this also.  What happens is
> that if you are logged on as a user, then su to root, it will fail.  If
> you log in directly as root, it will work.

This kind of differences (direct root login vs su) usualy are due to
different environment variable settings.

Just US$0.02
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
