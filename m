Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291061AbSBLUG1>; Tue, 12 Feb 2002 15:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291084AbSBLUGP>; Tue, 12 Feb 2002 15:06:15 -0500
Received: from codepoet.org ([166.70.14.212]:61406 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S291061AbSBLUF7>;
	Tue, 12 Feb 2002 15:05:59 -0500
Date: Tue, 12 Feb 2002 13:05:58 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-pre9-ac1
Message-ID: <20020212200558.GA6002@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020212092658.Z729@suse.de> <E16ae1e-0001ws-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16ae1e-0001ws-00@the-village.bc.nu>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.4.17-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Feb 12, 2002 at 02:35:18PM +0000, Alan Cox wrote:
> > > > I want to find out why it was done first and then test it. Leaving it out
> > > > will ensure it bugs me until I test it
> > > 
> > > If you leave it out, you surely want to make sure that the other request
> > > init and re-init paths agree on the clustering for MO devices. Because
> > > they don't.
> 
> No - I want to run a test set with an M/O drive before and after the change
> and see what it shows in real life. I suspect nothing much.

I was able to hang the kernel several times while talking 
to my MO drive prior to the fix...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
