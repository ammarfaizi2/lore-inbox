Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316528AbSE3Jcg>; Thu, 30 May 2002 05:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316530AbSE3Jcf>; Thu, 30 May 2002 05:32:35 -0400
Received: from codepoet.org ([166.70.14.212]:19377 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S316528AbSE3Jcf>;
	Thu, 30 May 2002 05:32:35 -0400
Date: Thu, 30 May 2002 03:32:36 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Paul P Komkoff Jr <i@stingr.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.19 - What's up with the kernel build?
Message-ID: <20020530093235.GA29851@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Russell King <rmk@arm.linux.org.uk>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Paul P Komkoff Jr <i@stingr.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205292019090.9971-100000@chaos.physics.uiowa.edu> <3CF5E698.2020806@mandrakesoft.com> <20020530085413.GA29170@codepoet.org> <20020530100144.B10611@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu May 30, 2002 at 10:01:44AM +0100, Russell King wrote:
> > Shockingly, not everyone uses mandrake's gcc 3.0.4...  ;-)
> > 
> > GCCINCDIR:= ${shell $(CC) -print-search-dirs | sed -ne "s/install: \(.*\)/\1include/gp"}
> > CFLAGS+=-nostdinc -I $(GCCINCDIR)
> 
> There is a nicer way of achieving the same thing:
> 
> CFLAGS	+= -nostdinc -iwithprefix include
> 
> `-iwithprefix DIR'
>      Add a directory to the second include path.  The directory's name

Cool, I didn't know about this one.  thanks,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
