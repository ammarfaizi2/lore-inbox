Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUDILpz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 07:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUDILpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 07:45:55 -0400
Received: from pop.gmx.de ([213.165.64.20]:14500 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261206AbUDILpj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 07:45:39 -0400
X-Authenticated: #1226656
Date: Fri, 9 Apr 2004 13:45:34 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: mru@kth.se (=?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?=),
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Marc Giger <gigerstyle@gmx.ch>, linux-kernel@vger.kernel.org
Subject: Re: status of Linux on Alpha?
Message-Id: <20040409134534.67805dfd@vaio.gigerstyle.ch>
In-Reply-To: <20040404121032.7bb42b35@vaio.gigerstyle.ch>
References: <yw1xsmftnons.fsf@ford.guide>
	<20040328201719.A14868@jurassic.park.msu.ru>
	<yw1xoeqhndvl.fsf@ford.guide>
	<20040328204308.C14868@jurassic.park.msu.ru>
	<20040328221806.7fa20502@vaio.gigerstyle.ch>
	<yw1xr7vcn1z2.fsf@ford.guide>
	<20040329205233.5b7905aa@vaio.gigerstyle.ch>
	<20040404121032.7bb42b35@vaio.gigerstyle.ch>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

Presently, I reached a stage on which I don't know longer what to do:-(
I isolated the problem between 2.6.3-rc1 and 2.6.3-rc2. I
also reverted 1.1608.56.1 , 1.1608.51.36 and all xfs related patches
from rc2 with no luck.
All other changes seems unrelated to me.

I'm really interested to solve the problem but I need your help.

What I noticed is that a make -j10 vmlinux triggers the problem the
fastest.

Thank you

Regards

Marc


On Sun, 4 Apr 2004 12:10:32 +0200
Marc Giger <gigerstyle@gmx.ch> wrote:

> Hi Ivan, Hi Måns
> 
> I've tested 2.6.3 on my alpha. It seems to be working fine. I couldn't
> trigger the problems that I had with 2.6.4.
> 
> So I will revert some patches witch I think could be the reason.
> 
> greets
> 
> Marc
> 
> On Mon, 29 Mar 2004 20:52:33 +0200
> Marc Giger <gigerstyle@gmx.ch> wrote:
> 
> > > 
> > > We could start by comparing .config files.  Mine is attached. 
> > > I've been running a 2.6.3 kernel with that configuration since it
> > > was released.  I compiled a gentoo installation using that kernel,
> > > so I'd say it's quite stable.
> > 
> > Ok, I've attached my config. I will take some time this week to
> > debug this problem.
> > Firstly, I will try out 2.6.3 and see what happens. I think that's
> > the best thing that I can do ATM. If the problem doesn't exist with
> > 2.6.3 on my alpha then we know where to search for.
> > 
> > Regards from Switzerland
> > 
> > Marc
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
