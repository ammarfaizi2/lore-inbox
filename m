Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbUB0CWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 21:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUB0CWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 21:22:21 -0500
Received: from 64-186-161-006.cyclades.com ([64.186.161.6]:57043 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261566AbUB0CWM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 21:22:12 -0500
Date: Fri, 27 Feb 2004 00:14:58 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Enrico Demarin <enricod@videotron.ca>
Cc: Jo Christian Buvarp <jcb@svorka.no>, linux-kernel@vger.kernel.org,
       "Moore, Eric Dean" <Emoore@lsil.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: Ibm Serveraid Problem with 2.4.25
In-Reply-To: <1077846502.4454.2.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58L.0402270011140.2029@logos.cnet>
References: <403DB882.9000401@svorka.no> <1077839333.4823.5.camel@localhost.localdomain>
 <1077846502.4454.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jo,

You're also using the MPT Fusion driver?

It has been updated in 2.4.25, and probably something broke. DAMN.

Eric, please look into this for us ?

On Thu, 26 Feb 2004, Enrico Demarin wrote:

> Hi everyone,
>
> I just checked, same message on a IBM x235 , it uses the
>
> Fusion MPT SCSI Host driver 2.05.11.03
>
> driver.
>
> Same message as you  ( except the offsets vary ) when I reboot.
>
> - Enrico
>
> On Thu, 2004-02-26 at 18:48, Enrico Demarin wrote:
> > I have the same here using the "partially opensource" drivers for a
> > Promise TX2... no message on 2.4.24.I wonder if it also means it's
> > corrupting the FS ? :(
> >
> >
> > - Enrico
> >
> > On Thu, 2004-02-26 at 04:12, Jo Christian Buvarp wrote:
> > > Just upgraded my server with the 2.4.25 kernel and I noticed an error :/
> > > The server is an IBM 345 with a Serveraid 5I controller, when doing an
> > > dmesg i get this error:
> > >
> > > attempt to access beyond end of device
> > > 08:05: rw=0, want=528036, limit=528034
> > > attempt to access beyond end of device
> > > 08:09: rw=0, want=65208120, limit=65208118
> > >
> > > This error only shows up in 2.4.25, when rebooting to 2.4.24 everything
> > > looks fine :)
> > > I tried upgrading the serveraid bios to the newest version (6.11.07),
> > > but i still got the error.
> > >
> > > So is this an bug in the kernel? Or do I have a problem on my server ?
> > > Is it safe to run 2.4.25 with this error ? Or should i go back to 2.4.24
