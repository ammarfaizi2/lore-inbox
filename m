Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276759AbRKSTIH>; Mon, 19 Nov 2001 14:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276988AbRKSTH6>; Mon, 19 Nov 2001 14:07:58 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:26335 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S276759AbRKSTHs>; Mon, 19 Nov 2001 14:07:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: x bit for dirs: misfeature?
Date: Mon, 19 Nov 2001 19:07:14 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111191644.fAJGileU019108@pincoya.inf.utfsm.cl> <E165sA9-0006Nv-00@mauve.csi.cam.ac.uk> <01111919395802.07749@nemo>
In-Reply-To: <01111919395802.07749@nemo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E165tl7-00023G-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 7:39 pm, vda wrote:
> On Monday 19 November 2001 17:24, James A Sutherland wrote:
> > > > Yes, I see... All I can do is to add workarounds (ok,ok, 'support')
> > > > to chmod and friends:
> > > >
> > > > chmod -R a+R dir  - sets r for files and rx for dirs
> > >
> > > X sets x for dirs, leaves files alone.
> >
> > Which sounds like exactly the behaviour the original poster wanted,
> > AFAICS?
>
> Yes, that sounds like the behaviour I want. But X flag does not do that.
> Sorry.

Oh? I just checked, and X *does* set the x bit on directories only, leaving 
files unaffected. What's wrong with that? Does it not do this on your system? 
Or do you want some other behaviour?

> James, I don't like flame wars. Lets ask ourself: does this thread have any
> useful results? Unfortunately, not many.
> Patches for chmod source would be better. Perhaps I should do that...

Patch it to do what? The current behaviour seems to me to be what you want...
 
> Let's refrain from "you're fool... go read manpage" type
> discussions. Not productive.

Agreed - if the question were covered in a manpage, I doubt there would be a 
thread here on LKML about it :)


James.
