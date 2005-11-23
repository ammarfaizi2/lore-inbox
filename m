Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbVKWAWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbVKWAWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 19:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbVKWAWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 19:22:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43726 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030272AbVKWAWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 19:22:04 -0500
Date: Tue, 22 Nov 2005 16:22:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Damien Wyart <damien.wyart@gmail.com>
Cc: adaplas@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: VESA fb console in 2.6.15
Message-Id: <20051122162226.41305851.akpm@osdl.org>
In-Reply-To: <87oe4c7gbv.fsf@brouette.noos.fr>
References: <20051121215531.GA3429@localhost.localdomain>
	<43826648.9030606@gmail.com>
	<87oe4c7gbv.fsf@brouette.noos.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damien Wyart <damien.wyart@gmail.com> wrote:
>
> > > I've noticed in several versions of 2.6.15 that VESA fb console
> > > seems completely broken : it draws screen in several very slow
> > > steps, making the whole display almos unusable. And it crashes
> > > *very* often, for example when switching to X. The computer is
> > > complety locked, and doesn't even respond to SysRQ.
> 
> > > I use vga=0x31B as boot param.
> 
> * "Antonino A. Daplas" <adaplas@gmail.com> [051122 01:28]:
> 
> > Try booting with:
> > vga=0x31b video=vesafb:mtrr:3
> 
> Thanks, this works fine with this param and also without any video=
> param. I had a default video=vesafb:mtrr:2 in my grub conf file because
> of mtrr problems a few kernel versions earlier (had been discussed
> extensively on this list). This setting doesn't work well in 2.6.15.
> 

Does 2.6.15-rc? work OK without any special boot options? (We want it to..)
