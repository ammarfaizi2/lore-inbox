Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262865AbVAKWpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbVAKWpB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbVAKWnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:43:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:50633 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262913AbVAKWl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:41:28 -0500
Date: Tue, 11 Jan 2005 14:41:26 -0800
From: Chris Wright <chrisw@osdl.org>
To: utz lehmann <lkml@s2y4n2c.de>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Lee Revell <rlrevell@joe-job.com>, "Jack O'Quin" <joq@io.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111144126.R10567@build.pdx.osdl.net>
References: <20050111195010.GU2940@waste.org> <871xcr3fjc.fsf@sulphur.joq.us> <20050111200549.GW2940@waste.org> <1105475349.4295.21.camel@krustophenia.net> <20050111124707.J10567@build.pdx.osdl.net> <20050111212823.GX2940@waste.org> <20050111134251.O10567@build.pdx.osdl.net> <20050111221618.GA2940@waste.org> <20050111142142.Q10567@build.pdx.osdl.net> <1105483011.4692.55.camel@segv.aura.of.mankind>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1105483011.4692.55.camel@segv.aura.of.mankind>; from lkml@s2y4n2c.de on Tue, Jan 11, 2005 at 11:36:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* utz lehmann (lkml@s2y4n2c.de) wrote:
> On Tue, 2005-01-11 at 14:21 -0800, Chris Wright wrote:
> > * Matt Mackall (mpm@selenic.com) wrote:
> > > On Tue, Jan 11, 2005 at 01:42:51PM -0800, Chris Wright wrote:
> 
> > > Also, tying to UIDs rather than (UID, executable) is worrisome as
> > > random_game_with_audio in Gnome might decide it needs RT, much to the
> > > admin's surprise.
> > 
> > Hmm, well, the pam_limit approach has that problem.
> 
> selinux?

Won't work (at least not now).  LIDS should do be able to do it.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
