Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317021AbSFQVId>; Mon, 17 Jun 2002 17:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSFQVIc>; Mon, 17 Jun 2002 17:08:32 -0400
Received: from ns.suse.de ([213.95.15.193]:32775 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317021AbSFQVIa>;
	Mon, 17 Jun 2002 17:08:30 -0400
Date: Mon, 17 Jun 2002 23:08:32 +0200
From: Dave Jones <davej@suse.de>
To: Bob Miller <rem@osdl.org>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v2.5.22 - add wait queue function callback support
Message-ID: <20020617230831.J758@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Bob Miller <rem@osdl.org>, Benjamin LaHaise <bcrl@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020617161434.D1457@redhat.com> <20020617222812.I758@suse.de> <20020617135744.A24347@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020617135744.A24347@doc.pdx.osdl.net>; from rem@osdl.org on Mon, Jun 17, 2002 at 01:57:44PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 01:57:44PM -0700, Bob Miller wrote:
 > > I thought we killed off wq_write_lock_irqsave 1-2 kernels ago ?
 > It depends on what you mean by killed off.  I submitted a patch to Linus back
 > at 2.5.3 to clean up the way the completion code called the wait queue
 > interface.  This interface got added then.  You picked up those changes at
 > that time (and still have them in your kernel tree) but the changes have
 > never made it into Linus' tree.
 > 
 > So, Linus has never had the code to 'kill' and you've never dropped it
 > after picking it up.

Your patch was to use wq_write_lock and friends in sched.c iirc.
That change is now removed from my tree (though I've not put up a
version containing that change yet).

Since 2.5.20 or so, the wq_write_lock functions are dead as in gone.
Not around, Extinct. They are ex-functions.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
