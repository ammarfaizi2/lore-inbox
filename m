Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVIDWKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVIDWKL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 18:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVIDWKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 18:10:10 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:33425 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932094AbVIDWKJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 18:10:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EFo2PEdUzUO2MH5QsJsuyVrMHS9t9vVKR0flQF0sujGvjmolfXjcVyICBp2SipeKEZYmALkE5tqRjwu4XiZYmWuO2ZuwMQm0J6RYSrYWNAevobcljrrBzSgUBnZVepcTJmj346v1DKIOzB8OQOqf8H7LO+A+QPTODbql28JJLI4=
Message-ID: <9a87484905090415107e82c725@mail.gmail.com>
Date: Mon, 5 Sep 2005 00:10:04 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] New: Omnikey CardMan 4040 PCMCIA Driver
Cc: Harald Welte <laforge@gnumonks.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <200509042106.j84L6kvV019764@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <jesper.juhl@gmail.com> <9a87484905090315273f9b7048@mail.gmail.com>
	 <200509042106.j84L6kvV019764@laptop11.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > On 9/4/05, Harald Welte <laforge@gnumonks.org> wrote:
> > > On Sun, Sep 04, 2005 at 12:12:18PM +0200, Harald Welte wrote:
> > > > Hi!
> > > >
> > > > Below you can find a driver for the Omnikey CardMan 4040 PCMCIA
> > > > Smartcard Reader.
> > >
> > > Sorry, the patch was missing a "cg-add" of the header file.  Please use
> > > the patch below.
> >
> > It would be so much nicer if the patch actually was "below" - that is
> > "inline in the email as opposed to as an attachment". Having to first
> > save an attachment and then cut'n'paste from it is a pain.
> >
> > Anyway, a few comments below :
> 
> [...]
> 
> > +     unsigned long ulBytesToRead;
> >
> >
> > lowercase prefered also for variables.
> 
> Also, "encoding" the type (ul) into the variable name is nonsense.
> 
Agreed, and it's even mentioned in CodingStyle (ok, it talks about
functions, but the same goes for variables):

...
Encoding the type of a function into the name (so-called Hungarian
notation) is brain damaged - the compiler knows the types anyway and can
check those, and it only confuses the programmer.  No wonder MicroSoft
makes buggy programs.

LOCAL variable names should be short, and to the point.  If you have
some random integer loop counter, it should probably be called "i".
Calling it "loop_counter" is non-productive, if there is no chance of it
being mis-understood.  Similarly, "tmp" can be just about any type of
variable that is used to hold a temporary value.
...



-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
