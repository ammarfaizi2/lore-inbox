Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVGGSvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVGGSvZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 14:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVGGStO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 14:49:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32909 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261569AbVGGSrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 14:47:07 -0400
Date: Thu, 7 Jul 2005 20:48:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Hansen <dave@sr71.net>
Cc: Clemens Koller <clemens.koller@anagramm.de>,
       Lenz Grimmer <lenz@grimmer.com>, Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050707184820.GA29449@suse.de>
References: <1120461401.3174.10.camel@laptopd505.fenrus.org> <20050704072231.GG1444@suse.de> <1120462037.3174.25.camel@laptopd505.fenrus.org> <20050704073031.GI1444@suse.de> <42C91073.80900@grimmer.com> <20050704110604.GL1444@suse.de> <20050707080323.GF1823@suse.de> <42CD600C.2000105@anagramm.de> <20050707172707.GI24401@suse.de> <1120757900.5829.38.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120757900.5829.38.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07 2005, Dave Hansen wrote:
> On Thu, 2005-07-07 at 19:27 +0200, Jens Axboe wrote:
> > On Thu, Jul 07 2005, Clemens Koller wrote:
> > > Well, sure, it's not a notebook HDD, but maybe it's possible
> > > to give headpark a more generic way to get the heads parked?
> > 
> > This _is_ the generic way, if your drive doesn't support it you are out
> > of luck.
> 
> I do wonder what is done in Windows, though...
> 
> They had to have had a method to park the drive there, or they probably
> wouldn't have even included the HDAPS driver in the first place.
> Anybody wanna strace the Windows app?

It's not unlikely that the drives that IBM shipped in that notebook used
a "secret" command or subfeature to park the head. It's a little strange
though, as they supposedly shipped various makes and models of drives
with the hdaps included. If they did use a vendor unique command for
parking the head, I bet it would be different for each make.

-- 
Jens Axboe

