Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273971AbRIXP44>; Mon, 24 Sep 2001 11:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273968AbRIXP4r>; Mon, 24 Sep 2001 11:56:47 -0400
Received: from web12304.mail.yahoo.com ([216.136.173.102]:6671 "HELO
	web12304.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S273971AbRIXP4d>; Mon, 24 Sep 2001 11:56:33 -0400
Message-ID: <20010924155654.89241.qmail@web12304.mail.yahoo.com>
Date: Mon, 24 Sep 2001 08:56:54 -0700 (PDT)
From: Stephen Cameron <smcameron@yahoo.com>
Subject: Re: Linux-2.4.10 - necessary patches
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > +/* Used to invoke Target Defice Reset for Fibre Channel */
> > +#define SCSI_IOCTL_FC_TDR 0x5388
> > +
> > +/* Used to get Fibre Channel WWN and port_id from device */
> > +#define SCSI_IOCTL_FC_TARGET_ADDRESS 0x5389
> > +
? 
? These are compaq made up ioctls. They shouldnt be merged like that. Instead
? there needs to be proper discussion about what is actualyl needed

Would it help to move these into a cpqfc specific header file? I'm
making changes to cpqfc already anyway (to use new DMA interfaces) so
I oculd move those ioctls while I was at it.

-- steve (aka steve.cameron@compaq.com)


__________________________________________________
Do You Yahoo!?
Get email alerts & NEW webcam video instant messaging with Yahoo! Messenger. http://im.yahoo.com
