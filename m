Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261387AbSI3XVM>; Mon, 30 Sep 2002 19:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261388AbSI3XVM>; Mon, 30 Sep 2002 19:21:12 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:52419 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261387AbSI3XVM>;
	Mon, 30 Sep 2002 19:21:12 -0400
Date: Mon, 30 Sep 2002 16:26:36 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, rmk@arm.linux.org.uk,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.20-pre8] irtty MODEM_BITS additional fix
Message-ID: <20020930232636.GA23948@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20020926023950.GA17708@bougret.hpl.hp.com> <Pine.LNX.4.44.0209301822500.32532-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209301822500.32532-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 06:23:21PM -0300, Marcelo Tosatti wrote:
> 
> 
> On Wed, 25 Sep 2002, Jean Tourrilhes wrote:
> 
> > 	Hi Marcelo,
> >
> > 	Alan did fix the compile of the irtty driver for i386 in
> > pre8. Unfortunately, there is still many platforms which doesn't
> > compile, including some that I know where IrDA is heavily used (PPC,
> > ARM).
> > 	This patch make sure the code works on all platforms. It's
> > 2.4.X, so I guess the code *must* work.
> >
> > 	Regards,
> 
> I'll remove that once we have all arch's OK.
> 
> Thanks

	I've no problem with that.
	Bear in mind that people are using IrDA on platform where you
would not suspect them to be, such as Alpha and PA-Risc, and many
obscure platforms, such as SH.
	I personally would like the platform people or the serial
people to look into that, because I don't feel qualified.

	Have fun...

	Jean

