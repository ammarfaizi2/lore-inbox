Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTKPW4d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 17:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTKPW4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 17:56:33 -0500
Received: from unthought.net ([212.97.129.88]:55990 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S263053AbTKPW4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 17:56:31 -0500
Date: Sun, 16 Nov 2003 23:56:29 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Pavel Machek <pavel@suse.cz>
Cc: Jens Axboe <axboe@suse.de>, Guillaume Chazarain <guichaz@yahoo.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cfq + io priorities
Message-ID: <20031116225629.GA14934@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
	Guillaume Chazarain <guichaz@yahoo.fr>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <SRLGXA875SP047EDQLEC055ZHDZX2V.3fae1da3@monpc> <20031109113928.GN2831@suse.de> <20031113125427.GB643@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031113125427.GB643@openzaurus.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 01:54:28PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > OK, I ask THE question : why not using the normal nice level, via
> > > current->static_prio ?
> > > This way, cdrecord would be RT even in IO, and nice -19 updatedb would have
> > > a minimal impact on the system.
> > 
> > I don't want to tie io prioritites to cpu priorities, that's a design
> > decision.
> 
> OTOH it might make sense to make "nice" command set
> both by default.

The syscall actually.

Users and developers alike, expect "nice" to mean "nice".

Having cpu_nice and io_nice too would be nice for completeness, if for
some unfathomable reason someone would want to set the one and not the
other.


All in my humble oppinion, of course  :)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
