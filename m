Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVGDUIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVGDUIG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 16:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVGDUIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 16:08:06 -0400
Received: from smtpout4.uol.com.br ([200.221.4.195]:55733 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261624AbVGDUFu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 16:05:50 -0400
Date: Mon, 4 Jul 2005 17:05:44 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Firewire/SBP2 and the -mm tree
Message-ID: <20050704200544.GA28900@ime.usp.br>
Mail-Followup-To: Stefan Richter <stefanr@s5r6.in-berlin.de>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	Andrew Morton <akpm@osdl.org>
References: <20050701044018.281b1ebd.akpm@osdl.org> <200507020005.04947.rjw@sisk.pl> <20050702031955.GC28251@ime.usp.br> <42C664CE.9020009@s5r6.in-berlin.de> <20050703053304.GA815@ime.usp.br> <20050703180455.GA1947@ime.usp.br> <42C84478.2020302@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42C84478.2020302@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 03 2005, Stefan Richter wrote:
> Rogério Brito wrote:
> >With 2.6.13-rc1-mm1, it works if I patch sbp2.[ch] *and* pass the
> >disable_irm parameter. If I don't pass the parameter, I get the same
> >strange behaviour as I did before.
> 
> Thanks for the systematic tests.

You're welcome. If I can be of any help, then please let me know.

> >I have not yet tested with a vanilla 2.6.13-rc1-mm1 (i.e., without
> >patching sbp2.[ch]) and with disable_irm=1. I can test this, if desired
> >or any other thing that you may want me to test.
> 
> We need to get it working without disable_irm.

There seems to be an undesired side-effect when I use disable_irm: my PS/2
mouse stops working in X. :-( I have not paid attention to any changes in
the dmesg output, but I didn't notice anything different from a regular
boot.  I can test it more as soon as I have some spare time.

> I hope to have some spare time sooner or later to look closer into it. I
> would get back to you if I come up with patches to try out or if somebody
> else proposes a fix.

I am, then, awaiting for any feedback from you or other linux1394 person.


Thank you, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
