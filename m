Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbVKVRRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbVKVRRL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbVKVRRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:17:11 -0500
Received: from pm-mx6.mgn.net ([195.46.220.208]:55709 "EHLO pm-mx6.mx.noos.fr")
	by vger.kernel.org with ESMTP id S965017AbVKVRRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:17:10 -0500
From: Damien Wyart <damien.wyart@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VESA fb console in 2.6.15
References: <20051121215531.GA3429@localhost.localdomain>
	<43826648.9030606@gmail.com>
Date: Tue, 22 Nov 2005 18:17:08 +0100
In-Reply-To: <43826648.9030606@gmail.com> (Antonino A. Daplas's message of
	"Tue, 22 Nov 2005 08:28:56 +0800")
Message-ID: <87oe4c7gbv.fsf@brouette.noos.fr>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've noticed in several versions of 2.6.15 that VESA fb console
> > seems completely broken : it draws screen in several very slow
> > steps, making the whole display almos unusable. And it crashes
> > *very* often, for example when switching to X. The computer is
> > complety locked, and doesn't even respond to SysRQ.

> > I use vga=0x31B as boot param.

* "Antonino A. Daplas" <adaplas@gmail.com> [051122 01:28]:

> Try booting with:
> vga=0x31b video=vesafb:mtrr:3

Thanks, this works fine with this param and also without any video=
param. I had a default video=vesafb:mtrr:2 in my grub conf file because
of mtrr problems a few kernel versions earlier (had been discussed
extensively on this list). This setting doesn't work well in 2.6.15.

-- 
Damien
