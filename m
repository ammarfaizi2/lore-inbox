Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272920AbTG3Ozp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272927AbTG3Ozp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:55:45 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:31112 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S272920AbTG3Oy4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:54:56 -0400
Date: Wed, 30 Jul 2003 11:50:50 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Ville Herva <vherva@niksula.hut.fi>
Cc: linux-kernel@vger.kernel.org, gibbs@scsiguy.com
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1, aic7xxx-6.2.36: solid
 hangs)
In-Reply-To: <20030730071321.GV150921@niksula.cs.hut.fi>
Message-ID: <Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva>
References: <20030729073948.GD204266@niksula.cs.hut.fi>
 <20030730071321.GV150921@niksula.cs.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 30 Jul 2003, Ville Herva wrote:

> On Tue, Jul 29, 2003 at 10:39:48AM +0300, you [Ville Herva] wrote:
> > After about a year of stable operation, a server begun acting up. First it
> > begun hanging up solid during the nightly oracle backup (that had run
> > successfully for a year), the I got some aic7xxx-related crashes on boot.
> >
> > Initially, the box ran 2.4.20pre7 kernel with aic7xxx version 6.4.8. When
> > the hangs started happening, I upgraded to 2.4.21-jam1 (basically 2.4.21
> > vanilla + -aa patch + some minor stuff) that includes aic7xxx version 6.2.36.
> > It did not help.
> >
> > I enabled kmsgdump and nmi watchdog, but when the box hangs, it hangs solid:
> > no ctrl-alt-del, no caps lock led, no alt-sysrq-b, no kmsgdump, nmi watchdog
> > doesn't trigger. Only the cursor on the console blinks, but no messages from
> > the kernel appear. (Apart from "spurious 8259A interrupt: IRQ7." that
> > always happens sometime after boot on this box, but way before the hang.)
>
> Herbert Pötzl indicted that he'd had similar lockups with fairly similar hw
> up until 2.4.22pre6. He suggested I should try 2.4.22pre8.
>
> 2.4.22pre8 locked up the same way in about 10 hours.
>
> > Any ideas on how to to debug this kind of hang?
>
> The question still stands; how do I debug this?
>
> > Does it sound kernel/driver or hw related? Are the two crashes related to
> > the hang? Is the hang related to aic7xxx?
>
> Any ideas?

Ville,

Mind trying 2.4.22-pre8 without MMAPIO defined in the SCSI driver?

Justin, is this problem known to other boards or.. ?
