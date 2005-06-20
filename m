Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVFTTuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVFTTuR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVFTTr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:47:29 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:35372 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261552AbVFTTqP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:46:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t9jBMc5PZJEBE7WlIXsfaDK4kdgYuALI1X4h4UjJgxaaYNrPID2wtdYcTc3CodOyONIhYNH5Bky8HGl6Ld5PHs3f/s7IFD/fDKS7oYJOBMQu12AcWyUm+hbI8ODVe25ZZwQX3QJVn/RoPvEsiIMzMVC0jz3aK396nMD3oMO4tu0=
Message-ID: <9a87484905062012464a76a175@mail.gmail.com>
Date: Mon, 20 Jun 2005 21:46:14 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Greg KH <gregkh@suse.de>
Subject: Re: 2.6.12 udev hangs at boot
Cc: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050620192118.GA13586@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506181332.25287.nick@linicks.net> <42B6FBC7.5000900@pobox.com>
	 <20050620173411.GB15212@suse.de> <200506202000.08114.nick@linicks.net>
	 <20050620192118.GA13586@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/05, Greg KH <gregkh@suse.de> wrote:
> On Mon, Jun 20, 2005 at 08:00:08PM +0100, Nick Warne wrote:
> > On Monday 20 June 2005 18:34, you wrote:
> >
> > > As for working with people's boxes, only the very oldest versions of
> > > udev (like the reported 030 version which is a year old and I do not
> > > think shipped by any distro) would have the "lockup" issue.  On all of
> > > the other ones, only custom rules written by users would have issues
> > > (meaning, not work).  I do not know of any shipping, supported distro
> > > that currently has a boot lockup issue (if so, please let me know.)
> >
> > It appears the issue people are seeing is with Slack 10, which shipped with
> > udev 0.26 - and I presume there was 'custom' rules Patrick had built in.
> 
> Ick.  Hm, there's not been any updates for slack since then? (note,
> there was no 0.26 release, there are no '.' in udev releases.)
> 
There has been updates since then.
There's been a newer stable Slackware release since 10.0. Slackware
10.1 was released on  2005-02-06 and ships udev 050.
Slackware-current (the unstable/development branch) is currently using udev 054.
Both the udev 050 and udev 054 Slackware packages should install fine
on a Slackware 10.0 box as far as I can see. So people just need to
upgrade their distro, or at least the udev bit of it :)
I'm running Slackware-current here with udev 054 and everything is just fine.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
