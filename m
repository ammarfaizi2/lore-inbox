Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281010AbRKTLAz>; Tue, 20 Nov 2001 06:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281011AbRKTLAq>; Tue, 20 Nov 2001 06:00:46 -0500
Received: from [195.66.192.167] ([195.66.192.167]:62983 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S281010AbRKTLAY>; Tue, 20 Nov 2001 06:00:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: x bit for dirs: misfeature?
Date: Tue, 20 Nov 2001 12:58:21 +0000
X-Mailer: KMail [version 1.2]
Cc: James A Sutherland <jas88@cam.ac.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <200111191814.fAJIEPlQ019878@pincoya.inf.utfsm.cl>
In-Reply-To: <200111191814.fAJIEPlQ019878@pincoya.inf.utfsm.cl>
MIME-Version: 1.0
Message-Id: <01112012582101.00810@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 18:14, Horst von Brand wrote:
> vda <vda@port.imtp.ilyichevsk.odessa.ua> said:
> > On Monday 19 November 2001 16:44, Horst von Brand wrote:
>
> [...]
>
> > > X sets x for dirs, leaves files alone.
> >
> > Hmm... yes this is one of such workarounds already implemented.
> > But it is not very good for my example:
> > X sets x for dirs *and* for files with x set for any of u,g,o.
> >
> > # chmod -R a+rX dir
> >
> > will make any executables (even root only) world-executable.
>
> That's what you are asking for...

?!

I'm asking for ability to make a tree _world-readable_ (and 
browsable), i.e. a+r on files and a+rx on dirs.
There is currently no chmod flag which will do that.
--
vda
