Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbTJRQlE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 12:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbTJRQlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 12:41:04 -0400
Received: from line103-242.adsl.actcom.co.il ([192.117.103.242]:9088 "EHLO
	beyondmobile1.beyondsecurity.com") by vger.kernel.org with ESMTP
	id S261695AbTJRQlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 12:41:01 -0400
From: Aviram Jenik <aviram@beyondsecurity.com>
Organization: Beyond Security Ltd.
To: Valdis.Kletnieks@vt.edu,
       mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns?=
	=?iso-8859-1?q?=20Rullg=E5rd?=)
Subject: Re: orinoco_cs module broken in test8
Date: Sat, 18 Oct 2003 18:36:12 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200310181723.54967.aviram@beyondsecurity.com> <yw1xoeweim2i.fsf@users.sourceforge.net> <200310181624.h9IGOgLW023089@turing-police.cc.vt.edu>
In-Reply-To: <200310181624.h9IGOgLW023089@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310181836.12402.aviram@beyondsecurity.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 October 2003 18:24, Valdis.Kletnieks@vt.edu wrote:
> On Sat, 18 Oct 2003 17:48:21 +0200, mru@users.sourceforge.net 
(=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)  said:
> > Aviram Jenik <aviram@beyondsecurity.com> writes:
> > > Orinoco_cs worked for me in all previous 2.6.0-testx versions, but
> > > stopped working in test8. Message log shows:
> > > kernel: orinoco_cs: RequestIRQ: Unsupported mode
> >
> > You have to enable ISA bus support, i.e. CONFIG_ISA=y.
>
> If it worked for him in earlier -testX, he must have had it set before...
>
> Aviram:  Is CONFIG_ISA=y in your -test8 .config?  If so, it's some other
> *new* problem. If not, do you have any idea how it got turned off ('make
> oldconfig' weirdness??)

Man's suggestion of CONFIG_ISA=y did solve the problem. I can't figure out how 
it was turned off, though. I just noticed several config options got disabled 
on this test kernel.

I wasn't running make oldconfig, though - I'm always running make menuconfig. 
Until now that was always saving my previous options (I've been trying every 
2.6.0-testx version) so I was assuming it was the right way to do it :-)

- Aviram
