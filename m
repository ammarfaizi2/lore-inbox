Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbULUL0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbULUL0C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 06:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbULUL0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 06:26:02 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:6551 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261733AbULULZu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 06:25:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=C8p2TCKnl90cfCMhsMUaYSeggu6tu3MSqBQza3Z/dAXduMmenkx8YTBa/P7hWlvi8hwZ6/JV8ODs+p0l87wb40gBPMQ/Bt6+FMxwf0esbWCy55c+0oC+VSXqslCttN8wZJKl0+eJE6Nd36HQMypq6v7eCotRAemMwCz2vagN5vA=
Message-ID: <f396da0804122103251c50bc5c@mail.gmail.com>
Date: Tue, 21 Dec 2004 13:25:49 +0200
From: Margus Eha <margus.eha@gmail.com>
Reply-To: Margus Eha <margus.eha@gmail.com>
To: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Re: Re : Re: Error - Kernel panic - not syncing:VFS:unable to mount root fs on unknown block (0,0)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041221111552.34872.qmail@web60608.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
References: <f396da0804122102561d30d04e@mail.gmail.com>
	 <20041221111552.34872.qmail@web60608.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well i said it a little fuzzy. You have IDE chipset support missing in kernel.
No need to add all ide support. Just pick chipset you have or use generic.

Margus

On Tue, 21 Dec 2004 03:15:52 -0800 (PST), selvakumar nagendran
<kernelselva@yahoo.com> wrote:
>   I am already having linux kernel 2.4 series which is
> working quite well. It also resides on the same root
> partition. I do have IDE.
>   Should I reconfigure  kernel 2.6 with all types of
> IDE support or is there any other way?
> 
> Thanks,
> selva
> 
> --- Margus Eha <margus.eha@gmail.com> wrote:
> 
> > Seems you are missing ide.
> >
> > Margus
> >
> >
> > On Tue, 21 Dec 2004 02:34:54 -0800 (PST), selvakumar
> > nagendran
> > <kernelselva@yahoo.com> wrote:
> > >   I installed the latest stable 2.6.9 kernel in my
> > > system. When I rebooted the system with the kernel
> > it
> > > showed the following error.
> > >
> > >      "Kernel panic - not syncing:VFS:unable to
> > mount
> > > root fs on unknown block (3,1)"
> > >
> > >     What is the solution to get rid of this error?
> > >     What is the measure to prevent such errors in
> > the
> > > future?
> > >      I downloaded the kernel source tar ball from
> > > kernel.org
> > >     Can anyone help me regarding this?
> > >
> > > Thanks,
> > > selva
> > >
> > > __________________________________
> > > Do you Yahoo!?
> > > All your favorites on one personal page â€" Try My
> > Yahoo!
> > > http://my.yahoo.com
> > > -
> > > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> >
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
>
