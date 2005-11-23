Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbVKWHgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbVKWHgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 02:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbVKWHgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 02:36:46 -0500
Received: from pm-mx6.mgn.net ([195.46.220.208]:46787 "EHLO pm-mx6.mx.noos.fr")
	by vger.kernel.org with ESMTP id S1030348AbVKWHgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 02:36:45 -0500
Date: Wed, 23 Nov 2005 08:36:43 +0100
From: Damien Wyart <damien.wyart@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: VESA fb console in 2.6.15
Message-ID: <20051123073643.GA7079@localhost.localdomain>
References: <20051121215531.GA3429@localhost.localdomain> <43826648.9030606@gmail.com> <87oe4c7gbv.fsf@brouette.noos.fr> <20051122162226.41305851.akpm@osdl.org> <4383B880.80301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4383B880.80301@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Try booting with: vga=0x31b video=vesafb:mtrr:3

> > > Thanks, this works fine with this param and also without any
> > > video= param. I had a default video=vesafb:mtrr:2 in my grub conf
> > > file because of mtrr problems a few kernel versions earlier (had
> > > been discussed extensively on this list). This setting doesn't
> > > work well in 2.6.15.

> > Does 2.6.15-rc? work OK without any special boot options? (We want it to..)

* Antonino A. Daplas <adaplas@gmail.com> [2005-11-23 08:32]:
> From what I understand, before this, he needs video=vesafb:mtrr:2.
> (Because his machine defaults to write-back mtrr instead of
> write-combining). Now it works without any special boot options
> because I made vesafb default to nomtrr because of problems like this
> and conflicts with X/DRI.

Exactly, I confirm that boot is ok without any special boot option.

-- 
Damien
