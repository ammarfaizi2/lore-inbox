Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWEQQgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWEQQgb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 12:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWEQQgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 12:36:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32387 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750703AbWEQQgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 12:36:31 -0400
Subject: Re: [linux-usb-devel] [PATCH/RFC 2.6.17-rc4 1/1]
	usbvideo/quickcam_messenger driver v4
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Jaya Kumar <jayakumar.video@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       video4linux-list@redhat.com
In-Reply-To: <70066d530605162314o5281a0b7yb933a1f405bc747c@mail.gmail.com>
References: <200605170236.k4H2avIu014840@localhost.localdomain>
	 <70066d530605162314o5281a0b7yb933a1f405bc747c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 17 May 2006 13:35:29 -0300
Message-Id: <1147883729.19297.1.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1-2mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jaya,


Please send the patches again. All arrived here with a "> " before every
patch line.

Cheers,
Mauro.

Em Qua, 2006-05-17 às 14:14 +0800, Jaya Kumar escreveu:
> [ My apologies again. Adding Mauro and video4linux-list to CC list. ]
> 
> On 5/17/06, jayakumar.video@gmail.com <jayakumar.video@gmail.com> wrote:
> > [ sorry, bungled the l-u-devel list address and subject in prev email ]
> >
> > Hi Greg KH, USB folk, kernel folk,
> >
> > Appended is v4 of my patch adding a usbvideo driver for the Logitech
> > Quickcam Messenger USB webcam. This patch has been rebased against
> > 2.6.17-rc4 as per Greg's feedback.
> >
> > Please let me know if it looks okay and if you have any feedback
> > or suggestions.
> >
> > Thanks,
> > Jaya Kumar
> >
> > Signed-off-by: Jaya Kumar <jayakumar.video@gmail.com>
> >
> > ---
> >
> >  Kconfig              |   12
> >  Makefile             |    1
> >  quickcam_messenger.c | 1120 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  quickcam_messenger.h |  126 +++++
> >  4 files changed, 1259 insertions(+)
> >
> > ---
> >
> > diff -X linux-2.6.17-rc4/Documentation/dontdiff -uprN linux-2.6.17-rc4-vanilla/drivers/media/video/usbvideo/Kconfig linux-2.6.17-rc4/drivers/media/video/usbvideo/Kconfig
> > --- linux-2.6.17-rc4-vanilla/drivers/media/video/usbvideo/Kconfig       2006-05-17 08:11:36.000000000 +0800
> > +++ linux-2.6.17-rc4/drivers/media/video/usbvideo/Kconfig       2006-05-17 08:39:51.674492008 +0800
> > @@ -36,3 +36,15 @@ config USB_KONICAWC
> >
> >          To compile this driver as a module, choose M here: the
> >          module will be called konicawc.


