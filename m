Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285944AbRLaBDY>; Sun, 30 Dec 2001 20:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286124AbRLaBDO>; Sun, 30 Dec 2001 20:03:14 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:60352 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S285944AbRLaBC5>;
	Sun, 30 Dec 2001 20:02:57 -0500
Date: Mon, 31 Dec 2001 12:02:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM driver patch okay?
Message-Id: <20011231120236.27c0a8d5.sfr@canb.auug.org.au>
In-Reply-To: <1009742756.9517.9.camel@thanatos>
In-Reply-To: <XFMail.20011223131241.ast@domdv.de>
	<1009742756.9517.9.camel@thanatos>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 30 Dec 2001 15:05:54 -0500
Thomas Hood <jdthood@mail.com> wrote:

> Hi Stephen 
> 
> Just a note to say that the patch combining "idling"
> and "notification order" changes is looking good so far.
>    http://panopticon.csustan.edu/thood/apm.html
> (No one has complained, anyway.)  I think it's ready
> for more extensive testing.  Should it go into a 2.4.X-preY
> kernel?

OK, I have a slightly modified version of the patch that I created just
before starting my Christmas break.  The only problem is that it crashes
the kernel hard when I remove the apm module.  I have not had a chance
to get back to it since then, but I am back at work in Wednesday and
it has my highest priority at the moment.

Question:  Has anyone got any empirical evidence that this patch
improves the idling behaviour?  i.e. does it consume less power or
lower the temperature?  I intend to try to measure this on Wednesday,
but a wider set of data is always better.

Thanks again for putting these patches together.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
