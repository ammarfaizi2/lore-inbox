Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131027AbRCFRHl>; Tue, 6 Mar 2001 12:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131031AbRCFRHd>; Tue, 6 Mar 2001 12:07:33 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:17687 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S131027AbRCFRGe>;
	Tue, 6 Mar 2001 12:06:34 -0500
Message-ID: <3AA518A7.FAE87846@sgi.com>
Date: Tue, 06 Mar 2001 09:04:39 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: God <atm@pinky.penguinpowered.com>, linux-kernel@vger.kernel.org
Subject: Re: Annoying CD-rom driver error messages
In-Reply-To: <E14aKqt-00012p-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > support to function efficiently -- perhaps that technology needs to be further developed
> > on Linux so app writers don't also have to be kernel experts and experts in all the
> > various bus and device types out there?
> 
> You mean someone should write a libcdrom that handles stuff like that - quite
> possibly
---
	More generally -- if I want to know if a DVD has been inserted and of what type
and/or a floppy has been inserted or a removable media of type "X" or perhaps
more generally -- not just if a 'device' has changed but a file or directory?

	I think that is what famd is supposed to do, but apparently it does so (I'm 
guessing from the external description) by polling and says it needs kernel support
to be more efficient.  Famd was apparently ported to Linux from Irix where it had
the kernel ability to be notified of changed file-space items (file-space = anything
accessible w/a pathname).


	Now if I can just remember where I saw this mythical port of the 'file-access
monitoring daemon'....

-l

-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
