Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbVLAPUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVLAPUq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 10:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVLAPUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 10:20:46 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:44488 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932268AbVLAPUp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 10:20:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fYHuodJ6T9AWFgF7JvgQpZWFZd0AqKmbJZPwkQ5zgQWwzlmMcGXuccTy9sfIURmy59X+zV5I8+mZNOujrW6FGz/koQpWLhhuVu5ebVb4jLsAXXqX7DGdffuyaP/Gf4ujsAh3YGgzlGBZ82XerS4F2JTMP+JoJObL2Usl9TXW7OY=
Message-ID: <58cb370e0512010720n2a02afc5y4efcbe1ee37092c8@mail.gmail.com>
Date: Thu, 1 Dec 2005 16:20:43 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       "David S. Miller" <davem@davemloft.net>, dwmw2@infradead.org,
       vagabon.xyz@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [NET] Remove ARM dependency for dm9000 driver
In-Reply-To: <20051201113744.GB19317@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051130190224.GE1053@flint.arm.linux.org.uk>
	 <1133426199.4117.179.camel@baythorne.infradead.org>
	 <20051201094111.GA14726@flint.arm.linux.org.uk>
	 <20051201.015115.49187117.davem@davemloft.net>
	 <20051201105227.GA19317@flint.arm.linux.org.uk>
	 <58cb370e0512010311s77a57305w5e9c7294ec09900a@mail.gmail.com>
	 <20051201113744.GB19317@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Thu, Dec 01, 2005 at 12:11:24PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On 12/1/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > > On Thu, Dec 01, 2005 at 01:51:15AM -0800, David S. Miller wrote:
> > > > So, bad example.
> > >
> > > Not in the IDE case.  Bart restricted IDE to a smaller number of ARM
> > > platforms, plus any that had PCMCIA.  There is no such restriction
> > > in the asm-arm/*.h header files.
> >
> > When I did this change there was such restriction in asm-arm/mach-*/ide.h
> > files (some platforms just lacked ide.h making IDE build break for them).
> >
> > IDE is a bad example anyway because of legacy ordering issues etc etc.
>
> Okay.  Given the general concensus in this thread, can this be removed
> now?

No, I didn't say that I agree with DaveM. :)

For IDE keeping restriction makes it much easier to maintain
(i.e. to answer questions like "why is this ugly hack needed?").

Bartlomiej
