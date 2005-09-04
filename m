Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbVIDStS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbVIDStS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 14:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbVIDStS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 14:49:18 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:24074 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751002AbVIDStS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 14:49:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OSyrFLvjYplGH8QBTtGvIJFUHPFfuhMTbD1783jG+428gd7itCDhqYCV66MIKO1XOK7/GbQDsuewesUYAlOpUIJ5fD/aaaYHrVtNEG7WVam8lGBZr7IL4a9MkjbcZHazwt994eG38PMHrLaKznT6/gz1T/RVqTywQr8EQ8Z2CeY=
Message-ID: <9a87484905090411492cc3f823@mail.gmail.com>
Date: Sun, 4 Sep 2005 20:49:15 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Matt LaPlante <laplam@rpi.edu>
Subject: Re: Potential IPSec DoS/Kernel Panic with 2.6.13
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
In-Reply-To: <200509041638.j84Gc5lA024062@ms-smtp-02-eri0.southeast.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1EBpnC-0001SQ-00@gondolin.me.apana.org.au>
	 <200509041638.j84Gc5lA024062@ms-smtp-02-eri0.southeast.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, Matt LaPlante <laplam@rpi.edu> wrote:
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> > owner@vger.kernel.org] On Behalf Of Herbert Xu
> > Sent: Sunday, September 04, 2005 4:24 AM
> > To: Matt LaPlante
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: Potential IPSec DoS/Kernel Panic with 2.6.13
> >
> > Matt LaPlante <laplam@rpi.edu> wrote:
> > >
> > > network connectivity on my router.  Upon further inspection I noticed
> > the
> > > packet had actually caused a kernel panic (visible only on the monitor,
> > now
> > > also unresponsive).
> >
> > Thanks for the report.  I'll try to track it down.
> >
> > If you could jot down the important bits of the panic message
> > (IP, Call-Trace) it would help me find the problem much quicker.
> 
> I'd be more than happy to help you track this one down.  The problem here is
> that the panic scrolls up and off the screen after which the system is
> unusable.  Is there a way for me to capture it or redirect it somewhere that
> I can read it?  I can also include my kernel config or any other system
> details of interest.  Thanks.
> 
serial console over a cross-over cable to a second box.
netconsole will let you put the console on a different box over the network.
console on line printer will let you have a permanent record of the
console output on paper.

See 
 Documentation/serial-console.txt
 Documentation/networking/netconsole.txt
 the help entry for "config LP_CONSOLE" (in drivers/char/Kconfig)


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
