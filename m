Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131464AbRCXABH>; Fri, 23 Mar 2001 19:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131410AbRCXAA7>; Fri, 23 Mar 2001 19:00:59 -0500
Received: from ip167-165.fli-ykh.psinet.ne.jp ([210.129.167.165]:23747 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S131419AbRCXAAk>;
	Fri, 23 Mar 2001 19:00:40 -0500
Message-ID: <3ABBE36F.89847A3C@yk.rim.or.jp>
Date: Sat, 24 Mar 2001 08:59:43 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Kurt Garloff <garloff@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Interesting post from the MC project to linux-kernel. :block while 
 spinlock held...
In-Reply-To: <3AB8E3E8.F3204180@yk.rim.or.jp> <20010322180528.B6264@garloff.casa-etp.nl>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Garloff-san,

Actually, a good question.

I have been trying to find the details of the verification tool from stanford

but to no avail.
Maybe we should ask the posters from the Stanford directly.

(Oops. I thought I posted this to linux-scsi, but did I post
linux-kernel instead? Apologies.)

Kurt Garloff wrote:

> On Thu, Mar 22, 2001 at 02:24:56AM +0900, Chiaki Ishikawa wrote:
> > --- begin quote ---
> > > enclosed are 163 potential bugs in 2.4.1 where blocking functions are
> > > called with either interrupts disabled or a spin lock held. The
> > > checker works by:
> >
> > Here's the file manifest. Apologies.
> >
> > drivers/atm/idt77105.c
> > drivers/atm/iphase.c
> > drivers/atm/uPD98402.c
> > drivers/block/cciss.c
> > drivers/block/cpqarray.c
> > drivers/char/applicom.c
> >     ...
> > drivers/scsi/aha1542.c            <--- some scsi files
> > drivers/scsi/atp870u.c             <----
> > drivers/scsi/psi240i.c               <----
> > drivers/scsi/sym53c416.c        <----
> > drivers/scsi/tmscsim.c              <----
>   ^^^^^^^^^^^^^^^^^^^^^^
>
> How do I fond about about details?
>
> R

