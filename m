Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272081AbRH2V2R>; Wed, 29 Aug 2001 17:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272082AbRH2V2I>; Wed, 29 Aug 2001 17:28:08 -0400
Received: from smtp-rt-3.wanadoo.fr ([193.252.19.155]:31686 "EHLO
	apicra.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S272081AbRH2V2C>; Wed, 29 Aug 2001 17:28:02 -0400
Message-ID: <3B8D5FC0.B2BB4FDD@wanadoo.fr>
Date: Wed, 29 Aug 2001 23:33:52 +0200
From: Pierre JUHEN <pierre.juhen@wanadoo.fr>
X-Mailer: Mozilla 4.77 [fr] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: fr, French, en
MIME-Version: 1.0
To: Dan Dennedy <dan@dennedy.org>
CC: linux-kernel@vger.kernel.org,
        Andreas Bombe <andreas.bombe@munich.netsurf.de>,
        "linux1394-devel@lists.sourceforge.net" 
	<linux1394-devel@lists.sourceforge.net>
Subject: Re: [pierre.juhen@wanadoo.fr: PROBLEM : OHCI1394 module crashes linux 
 with 2.4.9 (and 2.4.8 ?)]
In-Reply-To: <20010825031020.A30852@storm.local> <20010827225716.B5933@xtremedia>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded to gcc-2.96-85, which is supposed to be corrected. I
recompiled the kernel and modules.

It didn't solve the problem. 

modprobe ohci-1394 still crashes the system

Thanks,

Regards, 

Pierre 


Dan Dennedy a écrit :
> 
> On Fri, 24 Aug 2001 21:10:20 Andreas Bombe wrote:
> > This was sent to linux-kernel and me.  See what you can make of it.
> >
> > ----- Forwarded message from Pierre JUHEN <pierre.juhen@wanadoo.fr> -----
> >
> > Subject: PROBLEM : OHCI1394 module crashes linux with 2.4.9 (and 2.4.8 ?)
> >
> > [4.] Linux version 2.4.9 (root@pierre.juhen) (gcc version 2.96 20000731
> > (Red Hat Linux 7.1 2.96-81)) #2 dim aoû 19 19:02:56 CEST 2001
> [..]
> > Gnu C                  2.96
> 
> Maybe the problem is gcc 2.96--the notorious redhat version.
> 
> Try a google search on "gcc 2.96 -rpm" and see what it turns up.
> 
> FWIW, for other users here, in Arne Schirmacher's DV forums, we also have
> reports from users that libdv compiled with gcc 2.96 is generating
> artifacts in their decoded images.
