Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265575AbRF1HNg>; Thu, 28 Jun 2001 03:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265576AbRF1HN1>; Thu, 28 Jun 2001 03:13:27 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:49419 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S265575AbRF1HNK>; Thu, 28 Jun 2001 03:13:10 -0400
Date: 28 Jun 2001 08:54:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <83hAoTWHw-B@khms.westfalen.de>
In-Reply-To: <9hd7pl$86f$1@cesium.transmeta.com>
Subject: Re: [PATCH] User chroot
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <9hd7pl$86f$1@cesium.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com (H. Peter Anvin)  wrote on 27.06.01 in <9hd7pl$86f$1@cesium.transmeta.com>:

> By author:    kaih@khms.westfalen.de (Kai Henningsen)

> > jc@lysator.liu.se (Jorgen Cederlof)  wrote on 27.06.01 in
> > <20010627014534.B2654@ondska>:
> >
> > > If we only allow user chroots for processes that have never been
> > > chrooted before, and if the suid/sgid bits won't have any effect under
> > > the new root, it should be perfectly safe to allow any user to chroot.
> >
> > Hmm. Dos this work with initrd and root pivoting?
> >
>
> At the moment, yes.  Once Viro gets his root-changes in, this breaks,
> since ALL processes will be chrooted.

About what I expected. So you'd really want this flag to be resettable by  
root, if you go that way at all. Beginning to look a little too compley, I  
think.

The last time, ISTR we discussed some other, similar-but-different  
syscalls that made for more secure jails. I don't quite remember the  
details, though.


MfG Kai
