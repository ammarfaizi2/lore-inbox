Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268423AbTCDQGU>; Tue, 4 Mar 2003 11:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268677AbTCDQGT>; Tue, 4 Mar 2003 11:06:19 -0500
Received: from 237.oncolt.com ([213.86.99.237]:5356 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S268423AbTCDQGT>; Tue, 4 Mar 2003 11:06:19 -0500
Subject: Re: BitBucket: GPL-ed KitBeeper clone
From: David Woodhouse <dwmw2@infradead.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arador <diegocg@teleline.es>, "Adam J. Richter" <adam@yggdrasil.com>,
       andrea@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz, hch@infradead.org
In-Reply-To: <20030303001032.GD319@elf.ucw.cz>
References: <200303020011.QAA13450@adam.yggdrasil.com>
	 <20030302014915.34a6de37.diegocg@teleline.es>
	 <1046571336.24903.0.camel@irongate.swansea.linux.org.uk>
	 <3E615C38.7030609@pobox.com>  <20030303001032.GD319@elf.ucw.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1046794561.12066.42.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4.dwmw2) 
Date: 04 Mar 2003 16:16:01 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 00:10, Pavel Machek wrote:
> [bk's on-disk format is quite reasonable; it might be okay to reuse
> that.]

I disagree. Keeping the checked-out files _outside_ the repository, and
being able to have multiple checked-out trees from the same repository
with uncommitted changes outstanding while you pull from a remote
repository, etc, is useful.

cvs with cvsup does some of this but has obvious disadvantages, not
least of which being the one-way nature of change propagation. SVN and a
yet-to-be-invented SVNup (hopefully not in Modula-3) this time) may be a
lot closer to what we want.

-- 
dwmw2

