Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932662AbVIEJgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbVIEJgs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 05:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbVIEJgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 05:36:48 -0400
Received: from baythorne.infradead.org ([81.187.2.161]:26561 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S932662AbVIEJgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 05:36:46 -0400
Subject: Re: [ATMSAR] Request for review - update #1
From: David Woodhouse <dwmw2@infradead.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Giampaolo Tomassoni <g.tomassoni@libero.it>, linux-kernel@vger.kernel.org,
       linux-atm-general@lists.sourceforge.net
In-Reply-To: <200509041720.55588.s0348365@sms.ed.ac.uk>
References: <NBBBIHMOBLOHKCGIMJMDGEHPEKAA.g.tomassoni@libero.it>
	 <200509041720.55588.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Mon, 05 Sep 2005 10:36:36 +0100
Message-Id: <1125912996.6146.103.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-09-04 at 17:20 +0100, Alistair John Strachan wrote:
> Just out of curiosity, is there ANY reason why this has to be done in the 
> kernel? The PPPoATM module for pppd implements (via linux-atm) a completely 
> userspace ATM decoder.. if anything, now redundant ATM stack code should be 
> REMOVED from Linux!

No. The pppoatm module for pppd uses the kernel ATM stack and kernel
PPPoATM functionality. I suspect you're thinking of the pseudo-tty hack
used by the userspace code. 

> Most distributions (to my knowledge) supporting the speedtouch modem do so 
> using the method prescribed on speedtouch.sf.net; an entirely userspace 
> procedure. pppd does all the ATM magic.

Fedora doesn't; it uses the kernel driver.

-- 
dwmw2


