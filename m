Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbTHVNoa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 09:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263180AbTHVNoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 09:44:30 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:61648
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263167AbTHVNo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 09:44:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Wiktor Wodecki <wodecki@gmx.de>
Subject: Re: [PATCH]O18int
Date: Fri, 22 Aug 2003 23:51:16 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200308222231.25059.kernel@kolivas.org> <20030822134136.GA711@gmx.de>
In-Reply-To: <20030822134136.GA711@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308222351.16691.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 August 2003 23:41, Wiktor Wodecki wrote:
> On Fri, Aug 22, 2003 at 10:31:20PM +1000, Con Kolivas wrote:
> Content-Description: clearsigned data
>
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Here is a small patchlet.
> >
> > It is possible tasks were getting more sleep_avg credit on requeuing than
> > they could burn off while running so I've removed the on runqueue bonus
> > to requeuing task.
> >
> > Note this applies onto O16.3 or 2.6.0-test3-mm3 as O17 was dropped.
> >
> > This patch is also available here along with a patch against 2.6.0-test3:
> > http://kernel.kolivas.org/2.5
> >
> > Con
>
> this patch still makes my xmms skip on light io load (untar kernel
> source, open lkml mailbox folder) while opening mozilla. Even after
> mozilla is there xmms is still skipping. Processes take ages to spawn.
> And no, I'm not in swap. A 'su -'is taking 10 seconds to procceed.
> Same applies when rm -Rf'ing a kernel tree.
> Here is some more data for the curious:

> note the load of 11. I can even get it to 30 while doing 3 tar xf
> bla.tar simultanously.

Complete mystery.
>
> I'm going to fetch some fish in the next two weeks in poland, so I will
> not be able to do any more testing from sunday on. Happy coding (while I
> stick to O10 *g*)

Thanks for comments. ]

There it is again; the reference to darn O10. Hrm. One question before your 
holiday; your O10 kernel is it the same kernel tree or a different/newere 
one? I'm looking to blame something else here I know but I need to know; this 
just doesn't hold with any testing here.

Con

