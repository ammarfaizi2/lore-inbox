Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVGCSFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVGCSFK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 14:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVGCSFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 14:05:10 -0400
Received: from smtpout5.uol.com.br ([200.221.4.196]:58594 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261485AbVGCSFA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 14:05:00 -0400
Date: Sun, 3 Jul 2005 15:04:55 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Subject: Re: Firewire/SBP2 and the -mm tree
Message-ID: <20050703180455.GA1947@ime.usp.br>
Mail-Followup-To: Stefan Richter <stefanr@s5r6.in-berlin.de>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	Andrew Morton <akpm@osdl.org>
References: <20050701044018.281b1ebd.akpm@osdl.org> <200507020005.04947.rjw@sisk.pl> <20050702031955.GC28251@ime.usp.br> <42C664CE.9020009@s5r6.in-berlin.de> <20050703053304.GA815@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050703053304.GA815@ime.usp.br>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All.

This is just an update on my earlier e-mail.

On Jul 03 2005, Rogério Brito wrote:
> On Jul 02 2005, Stefan Richter wrote:
> > I have a question: Do you need _both_ the sbp2 back-out and ieee1394's
> > disable_irm parameter, or only one of them?
> 
> But with the recently released 2.6.13-rc1-mm1, patching the sbp2.[ch]
> files isn't sufficient anymore (i.e., I get results similar to what I had
> when I first started this thread).

With 2.6.13-rc1-mm1, it works if I patch sbp2.[ch] *and* pass the
disable_irm parameter. If I don't pass the parameter, I get the same
strange behaviour as I did before.

I have not yet tested with a vanilla 2.6.13-rc1-mm1 (i.e., without patching
sbp2.[ch]) and with disable_irm=1. I can test this, if desired or any other
thing that you may want me to test.


Thanks, Rogério Brito.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
