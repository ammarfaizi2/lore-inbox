Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935783AbWK1J6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935783AbWK1J6p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 04:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935784AbWK1J6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 04:58:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52864 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S935783AbWK1J6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 04:58:44 -0500
Subject: Re: [2.6 patch] remove the broken VIDEO_ZR36120 driver
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: jfeise@feise.com
Cc: Adrian Bunk <bunk@stusta.de>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Pauline Middelink <middelink@polyware.nl>
In-Reply-To: <456BD8E4.6010003@feise.com>
References: <20061125191510.GB3702@stusta.de> <456BC973.1050309@feise.com>
	 <20061128060723.GA15364@stusta.de>  <456BD8E4.6010003@feise.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 28 Nov 2006 07:57:39 -0200
Message-Id: <1164707859.12613.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

Em Seg, 2006-11-27 às 22:36 -0800, Joe Feise escreveu:
> Adrian Bunk wrote on 11/27/06 22:07:
> 
> > On Mon, Nov 27, 2006 at 09:30:27PM -0800, Joe Feise wrote:
> >> Adrian Bunk wrote on 11/25/06 11:15:
> >>
> >>> But if anyone wants to ever revive this driver, the code is still 
> >>> present in the older kernel releases.
> >> Hmm, there are people out there (like me) who still use it and have patched it
> >> to get it working on 2.6.x.
> > If you anyway have to patch your kernel, you can as well patch the 
> > complete driver into the kernel.
> Well, there are other things outside the actual driver code that may change, and
> that would make it harder to keep my patch in sync.
Keeping it in sync is not hard. Most changes are just small API changes
that are easy to port to all drivers, since they all behave likely.
Also, when kernel hackers changes API, they usually send patches fixing
API also at the affected drivers (of course for not-broken stuff).
> And actually, I submitted my patch some time ago to the maintainer of the driver
> (Pauline Middelink.)  Unfortunately, it never made it into the kernel, nor did I
> get any feedback from her. I have no idea if she is still active (she is listed
> as maintainer at least until 2.6.17.) I cc'ed her on this mail.
If you are interested on fixing this driver, you may submit the fix
patch to me, with your SOB. I'm maintaining the V4L subsystem as a hole.
> 
> 
> -Joe
> 
> 
Cheers, 
Mauro.

