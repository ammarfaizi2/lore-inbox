Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTIRLl1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 07:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbTIRLl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 07:41:27 -0400
Received: from users.linvision.com ([62.58.92.114]:38830 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id S261196AbTIRLlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 07:41:24 -0400
Date: Thu, 18 Sep 2003 13:39:03 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Pavel Machek <pavel@suse.cz>
Cc: Jens Axboe <axboe@suse.de>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       neilb@cse.unsw.edu.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <20030918133903.A14355@bitwizard.nl>
References: <20030916102113.0f00d7e9.skraw@ithnet.com> <Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet> <20030916153658.3081af6c.skraw@ithnet.com> <1063722973.10037.65.camel@dhcp23.swansea.linux.org.uk> <20030917084102.A19276@bitwizard.nl> <20030917102629.GL906@suse.de> <20030917191929.GC9125@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030917191929.GC9125@openzaurus.ucw.cz>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 09:19:29PM +0200, Pavel Machek wrote:
> Heh, old ide disk in PIO mode should allow that 6GB machine
> to perform better...
> At least you don't loose packets during PIO reads...

As long as you tune it 
	hdparm -i1 /dev/hdX

Roger. 
> 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
