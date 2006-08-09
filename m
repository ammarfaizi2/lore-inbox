Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWHIQoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWHIQoK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWHIQoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:44:09 -0400
Received: from mx27.mail.ru ([194.67.23.65]:38713 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S1750996AbWHIQoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:44:08 -0400
Date: Wed, 9 Aug 2006 19:44:03 +0300
From: Sergei Steshenko <steshenko_sergei@list.ru>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: "Sam Ravnborg" <sam@ravnborg.org>,
       "Benoit Fouet" <benoit.fouet@purplelabs.com>,
       "Gene Heskett" <gene.heskett@verizon.net>,
       alsa-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Alsa-user] another in kernel alsa update that breaks backward
 compatibilty?
Message-ID: <20060809194403.5960132c@comp.home.net>
In-Reply-To: <d120d5000608090936j794449e9v6c57ac44801bd3d5@mail.gmail.com>
References: <200608091140.02777.gene.heskett@verizon.net>
	<20060809184658.2bdfb169@comp.home.net>
	<44DA05C9.5050600@purplelabs.com>
	<20060809160043.GA12571@mars.ravnborg.org>
	<20060809191748.7550edaa@comp.home.net>
	<d120d5000608090936j794449e9v6c57ac44801bd3d5@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.3; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2006 12:36:23 -0400
"Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:

> On 8/9/06, Sergei Steshenko <steshenko_sergei@list.ru> wrote:
> > On Wed, 9 Aug 2006 18:00:43 +0200
> > Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > > On Wed, Aug 09, 2006 at 05:56:57PM +0200, Benoit Fouet wrote:
> > > > >
> > > > >Demand stable ABI.
> > > > >
> > > > >
> > > > >
> > > > sorry for the noise, but it's been a while now since i began reading
> > > > mails from this list, and i must admit i don't always (never?) see the
> > > > point of such messages...
> > > > if you can help me understand, i'll be very happy to get something more
> > > > detailed from you...
> > > Documentation/stable_api_nonsense.txt
> > >
> > >       Sam
> > >
> >
> > I love senselessness and technical incompetence of the document.
> >
> > As I was taught at school, to prove that a statement is wrong one
> > has to prove that it is wrong once.
> >
> 
> Yep, the only trick is that you need a valid proof ;)
> 
> > Regardless of what the document says stable ABI can be achieved
> > today - run a chosen Linux kernel version + chosen ALSA version under XEN or
> > similar, and assign sound card to these (chosen Linux kernel version +
> > chosen ALSA version).
> >
> > Redirect sound ('ncat' + friends) to this (chosen Linux kernel version +
> > chosen ALSA version) from your kernel in which developers refuse
> > to ensure stable ABI.
> >
> > Because of the chosen (kernel+ALSA) you have stable ABI regardless
> > of what Documentation/stable_api_nonsense.txt says and ALSA + kernel
> > developers think.
> >
> 
> You are confused. By your logic you do not need XEN at all - just take
> a kernel version + alsa and never change/update it - and viola!
> "stable" ABI.
> 

I simply described how one ABI (ALSA <-> kernel in this case) can
be stabilized, while new non-ALSA related features (and potentially
unstable ABI) can still be had.

If computer has enough resources, practically every ABI can be
stabilized (if desired) this way - as long as the ABI is PCI slot
related.

That is, I can, for example, stabilize ALSA-kernel interface choosing
(ALSA 1.0.11 + kernel 2.6.17) and I can stabilize TV card interface
using (whatever v4l + kernel 2.6.18), etc,

--Sergei.
-- 
Visit my http://appsfromscratch.berlios.de/ open source project.
