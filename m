Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131036AbRCFR3N>; Tue, 6 Mar 2001 12:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131040AbRCFR3D>; Tue, 6 Mar 2001 12:29:03 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:12307 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S131036AbRCFR2u>;
	Tue, 6 Mar 2001 12:28:50 -0500
Date: Tue, 06 Mar 2001 18:28:40 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Annoying CD-rom driver error messages
To: law@sgi.com
Cc: linux-kernel@vger.kernel.org
Message-id: <3AA51E48.17333215@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LA Walsh (law@sgi.com) wrote:

> Alan Cox wrote: 
> > 
> > > support to function efficiently -- perhaps that technology needs to be further developed 
> > > on Linux so app writers don't also have to be kernel experts and experts in all the 
> > > various bus and device types out there? 
> > 
> > You mean someone should write a libcdrom that handles stuff like that - quite 
> > possibly 
> 
> ---
>         More generally -- if I want to know if a DVD has been inserted and of what type
> and/or a floppy has been inserted or a removable media of type "X" or perhaps
> more generally -- not just if a 'device' has changed but a file or directory?
>         I think that is what famd is supposed to do, but apparently it does so (I'm 
> guessing from the external description) by polling and says it needs kernel support
> to be more efficient.  Famd was apparently ported to Linux from Irix where it had
> the kernel ability to be notified of changed file-space items (file-space = anything
> accessible w/a pathname).
>         Now if I can just remember where I saw this mythical port of the 'file-access
> monitoring daemon'....

This notification exists in 2.4.x ( at least the docs say so :-)
see /usr/src/linux/Documentation/dnotify.txt 

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
