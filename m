Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVJYQYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVJYQYp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 12:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbVJYQYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 12:24:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62394 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932195AbVJYQYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 12:24:44 -0400
Date: Tue, 25 Oct 2005 18:24:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Sharp zaurus c-3000
Message-ID: <20051025162427.GA8492@elf.ucw.cz>
References: <20051024211632.GA7127@elf.ucw.cz> <1130191145.8345.185.camel@localhost.localdomain> <20051025083231.GA7927@elf.ucw.cz> <1130232335.8235.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130232335.8235.20.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[cc to the list]

> > > Your other alternative is to perform a NAND Restore, if you can find a
> > > NAND backup for the C3000. The D+M menu has an option for this and I'm
> > > sure it will also be documented on the web. When in this state I
> > > couldn't get that to work on my c760 though it could have been the image
> > > I was trying to restore it with or my CF card...
> > 
> > D+M menu still works for me, so I tried this one -- on SD card (my CF
> > card is only 16MB). Not sure what I'm doing wrong.
> > 
> > pavel@amd:/data/l/zaurus$ md5sum /mnt/systc300.dbk
> > 6a37ce6a4bee0b7a39fd0140c70eda16  /mnt/systc300.dbk
> > -rwxr-xr-x   1 root root 17317904 Jan  1  2003 systc300.dbk*
> > 
> > I only tried "NAND update". Should I do "Erase / NAND update"? Result
> > was
> > 
> > SD update
> > --- Found orders ---
> > Error!!!
> 
> This might mean you've also broken D+M. I couldn't get it to work when I
> had this problem either. Whether that was me or whether it was truly
> broken, I don't know.
> 
> That leaves the low level loader to restore NAND. Were you able to find
> C3000 images anywhere? If not, I can perhaps have a try and extracting
> them from my C3000. You should just need to fix the initrd partition I
> guess...

I managed to recover it. There are actually two "NAND update" options
in D+M menu (at different places). One of them works, second does
not. Oops. Just for the record, usefull files are at
http://www.trisoft.de/download . 
								Pavel
-- 
Thanks, Sharp!
