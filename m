Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273192AbRIJE0P>; Mon, 10 Sep 2001 00:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273193AbRIJE0F>; Mon, 10 Sep 2001 00:26:05 -0400
Received: from mail.tconl.com ([204.26.80.9]:21510 "EHLO hermes.tconl.com")
	by vger.kernel.org with ESMTP id <S273192AbRIJEZz>;
	Mon, 10 Sep 2001 00:25:55 -0400
Message-ID: <3B9C40DB.F6669FCD@tconl.com>
Date: Sun, 09 Sep 2001 23:26:03 -0500
From: Joe Fago <cfago@tconl.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.5 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Grant <davidgrant79@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9: PDC20267 not working
In-Reply-To: <Pine.LNX.4.21.0109091843220.31509-100000@inbetween.blorf.net> <OE39Zeh7UmNgW6VPMzP00004bf8@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > On Sun, 9 Sep 2001, Joe Fago wrote:
> >
> > > System hangs on boot:
> >
> > > PDC20267: IDE controller on PCI bus 00 dev 40
> >
> > > This is the only device attached to the controller. Any suggestions?
> >
> > You can try setting interrupts to edge-triggered in your
> > BIOS if it has such an option; 
>
> Joe: what error messages do you get?  I get
> the "hde: timeout waiting for dma" errors.  After that I have to cold start

I had no more information, the system just hung after the `hda:' line. Setting
the
bios to interrupts triggered by `level' seems to get things going in my case.

I guess these are workarounds rather than solutions. I was just happy to
get the system booted. It seems that we can reproduce this particular problem,
and I'd be glad to participate in any testing that might assist Andre's efforts.

Thanks,
Joe
