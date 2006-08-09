Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWHITyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWHITyF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 15:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWHITyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 15:54:05 -0400
Received: from mx27.mail.ru ([194.67.23.65]:57907 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S1750878AbWHITyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 15:54:04 -0400
Date: Wed, 9 Aug 2006 22:53:59 +0300
From: Sergei Steshenko <steshenko_sergei@list.ru>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: "Sam Ravnborg" <sam@ravnborg.org>,
       "Benoit Fouet" <benoit.fouet@purplelabs.com>,
       "Gene Heskett" <gene.heskett@verizon.net>,
       alsa-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Alsa-user] another in kernel alsa update that breaks backward
 compatibilty?
Message-ID: <20060809225359.24c90e09@comp.home.net>
In-Reply-To: <d120d5000608091054s1c1a2a4cre33341c9b1f69ee9@mail.gmail.com>
References: <200608091140.02777.gene.heskett@verizon.net>
	<20060809184658.2bdfb169@comp.home.net>
	<44DA05C9.5050600@purplelabs.com>
	<20060809160043.GA12571@mars.ravnborg.org>
	<20060809191748.7550edaa@comp.home.net>
	<d120d5000608090936j794449e9v6c57ac44801bd3d5@mail.gmail.com>
	<20060809194403.5960132c@comp.home.net>
	<d120d5000608091054s1c1a2a4cre33341c9b1f69ee9@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.3; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2006 13:54:29 -0400
"Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:

> On 8/9/06, Sergei Steshenko <steshenko_sergei@list.ru> wrote:
> > On Wed, 9 Aug 2006 12:36:23 -0400
> > "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:
> > >
> > > You are confused. By your logic you do not need XEN at all - just take
> > > a kernel version + alsa and never change/update it - and viola!
> > > "stable" ABI.
> > >
> >
> > I simply described how one ABI (ALSA <-> kernel in this case) can
> > be stabilized, while new non-ALSA related features (and potentially
> > unstable ABI) can still be had.
> >
> > If computer has enough resources, practically every ABI can be
> > stabilized (if desired) this way - as long as the ABI is PCI slot
> > related.
> >
> 
> And in extreme case once you "stablizie" everything you end up with a
> system that is not upgradeable at all.
> 
> > That is, I can, for example, stabilize ALSA-kernel interface choosing
> > (ALSA 1.0.11 + kernel 2.6.17) and I can stabilize TV card interface
> > using (whatever v4l + kernel 2.6.18), etc,
> >
> 
> But you are not stabilizing ABI, you are freezing a subsystem. Stable
> ABI does not mean that bugs do not get fixed and new hardware support
> is not being addeed, as in your case.
> 

I did stabilize ABI - I can be using the same (bit to bit) audio driver
regardless of changes in the kernel not related to ALSA.

I can consider this whole ugly and clumsy construct as a "super"
kernel in which by construction nothing changes in the audio part.

That, I as end user don't care what developers break in the non-audio
part of this kernel - for me audio part is stable.

I let the non-audio part evolve while the audio part remains the
same - even at binary level.

--Sergei.

-- 
Visit my http://appsfromscratch.berlios.de/ open source project.
