Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131481AbRD2UaX>; Sun, 29 Apr 2001 16:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136330AbRD2UaO>; Sun, 29 Apr 2001 16:30:14 -0400
Received: from pcow029o.blueyonder.co.uk ([195.188.53.123]:28423 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S131481AbRD2UaA>;
	Sun, 29 Apr 2001 16:30:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Gauld <duncan@gauldd.freeserve.co.uk>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
Subject: Re: question regarding cpu selection
Date: Sun, 29 Apr 2001 21:28:48 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <01042919075101.01335@pc-62-31-91-135-dn.blueyonder.co.uk> <20010429145608.A703@better.net> <20010429223641.K3529@niksula.cs.hut.fi>
In-Reply-To: <20010429223641.K3529@niksula.cs.hut.fi>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01042921284803.01335@pc-62-31-91-135-dn.blueyonder.co.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 April 2001  3:36 pm, Ville Herva wrote:
> On Sun, Apr 29, 2001 at 02:56:08PM -0400, you [William Park] claimed:
> > On Sun, Apr 29, 2001 at 07:07:51PM -0400, Duncan Gauld wrote:
> > > Hi,
> > > This seems a silly question but - I have an intel celeron 800mhz CPU
> > > and thus it is of the Coppermine breed. But under cpu selection when
> > > configuring the kernel, should I select PIII or PII/Celeron? Just
> > > wondering, since Coppermine is basically a newish PIII with 128K less
> > > cache...
> >
> > Try both, and see if your machine throws up.
>
> 800Mhz Celeron is actually a CeleronII, and it does SSE just like PIII (the
> only difference being cache). Therefore PIII option should work.
>
> Perhaps this should be fixed in the config menu (or is it already? Which
> kernel are you compiling?)

compiling kernel 2.4.4 on mandrake 8.
Just checked - no mention of Celeron II in there-
   Pentium Pro/Pentium II/Celeron
is the only line mentioning the celeron; maybe the PIII line could be changed 
to something like "Pentium III/Celeron II"?
I would supply a patch, but I don't know how to write such a thing :)

---
Duncan Gauld
dunkers@blueyonder.co.uk
http://www.freelin.org (linux on cd, free)
