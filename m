Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267189AbUIEUYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUIEUYn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 16:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267205AbUIEUYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 16:24:43 -0400
Received: from host-63-144-52-41.concordhotels.com ([63.144.52.41]:22553 "EHLO
	080relay.CIS.CIS.com") by vger.kernel.org with ESMTP
	id S267189AbUIEUYl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 16:24:41 -0400
Subject: Re: [BUG] r200 dri driver deadlocks
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Patrick McFarland <diablod3@gmail.com>
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
In-Reply-To: <d577e569040905131870fa14a3@mail.gmail.com>
References: <d577e569040904021631344d2e@mail.gmail.com>
	 <1094321696.31459.103.camel@admin.tel.thor.asgaard.local>
	 <d577e56904090413365f5e223d@mail.gmail.com>
	 <1094366099.31457.112.camel@admin.tel.thor.asgaard.local>
	 <d577e56904090501224f252dbc@mail.gmail.com>
	 <1094406055.31464.118.camel@admin.tel.thor.asgaard.local>
	 <d577e569040905131870fa14a3@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Sun, 05 Sep 2004 16:25:00 -0400
Message-Id: <1094415901.31465.133.camel@admin.tel.thor.asgaard.local>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-05 at 16:18 -0400, Patrick McFarland wrote:
> On Sun, 05 Sep 2004 13:40:54 -0400, Michel Dänzer <michel@daenzer.net> wrote:
> > On Sun, 2004-09-05 at 04:22 -0400, Patrick McFarland wrote:
> > > On Sun, 05 Sep 2004 02:34:59 -0400, Michel Dänzer <michel@daenzer.net> wrote:
> > > >
> > > > Where did you get r200_dri.so from?
> > >
> > > From the one that comes with the Deb X I mentioned above.
> > 
> > Please try something newer, e.g. my xlibmesa-gl1-dri-trunk or a binary
> > snapshot from dri.sf.net.
> 
> That shouldn't matter, should it? The userland stuff should never lock
> the machine up.

In an ideal world... Feel free to track down the cause and add code to
the DRM to prevent it.


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer
