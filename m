Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266682AbRG1OR4>; Sat, 28 Jul 2001 10:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266684AbRG1ORg>; Sat, 28 Jul 2001 10:17:36 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:38669 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266682AbRG1ORf>; Sat, 28 Jul 2001 10:17:35 -0400
X-Apparently-From: <kiwiunixman@yahoo.co.nz>
Content-Type: text/plain; charset=US-ASCII
From: Matthew Gardiner <kiwiunixman@yahoo.co.nz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, bvermeul@devel.blackstar.nl
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Date: Sun, 29 Jul 2001 02:16:13 +1200
X-Mailer: KMail [version 1.2]
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), reiser@namesys.com (Hans Reiser),
        J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw), haiquy@yahoo.com (Steve Kieu),
        samuelt@cervantes.dabney.caltech.edu (Sam Thompson),
        linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <E15Q7q5-0005e9-00@the-village.bc.nu>
In-Reply-To: <E15Q7q5-0005e9-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01072902161303.02683@kiwiunixman.nodomain.nowhere>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Saturday 28 July 2001 01:39, Alan Cox wrote:
> > > Putting a sync just before the insmod when developing new drivers is a
> > > good idea btw
> >
> > I've been doing that most of the time. But I sometimes forget that.
> > But as I said, it's not something I expected from a journalled
> > filesystem.
>
> You misunderstand journalling then
>
> A journalling file system can offer different levels of guarantee. With
> metadata only journalling you don't take any real performance hit but your
> file system is always consistent on reboot (consistent as in fsck would
> pass it) but it makes no guarantee that data blocks got written.
>
> Full data journalling will give you what you expect but at a performance
> hit for many applications.
>
> Alan

Just in regards to full journalling, will/is there an option in ReiserFS to 
allow it? Personally, I would much rather have full journalling, and a little 
more of a performance hit for security and reliability, than great 
performance and a higher level of risk.

Matthew Gardiner
-- 
WARNING:

This email was written on an OS using the viral 'GPL' as its license.

Please check with Bill Gates before continuing to read this email/posting.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

