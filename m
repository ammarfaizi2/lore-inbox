Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbVIENyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVIENyR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 09:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVIENyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 09:54:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8428 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932288AbVIENyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 09:54:16 -0400
Subject: Re: [ATMSAR] Request for review - update #1
From: David Woodhouse <dwmw2@infradead.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Giampaolo Tomassoni <g.tomassoni@libero.it>, linux-kernel@vger.kernel.org,
       linux-atm-general@lists.sourceforge.net
In-Reply-To: <200509051452.21075.s0348365@sms.ed.ac.uk>
References: <NBBBIHMOBLOHKCGIMJMDGEHPEKAA.g.tomassoni@libero.it>
	 <200509041720.55588.s0348365@sms.ed.ac.uk>
	 <1125912996.6146.103.camel@baythorne.infradead.org>
	 <200509051452.21075.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Mon, 05 Sep 2005 14:56:20 +0100
Message-Id: <1125928580.29448.33.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-05 at 14:52 +0100, Alistair John Strachan wrote:
> I'm not sure which module you're referring to, but the patch recommended by 
> the speedtouch people links to linux-atm, and does not require kernel ATM or 
> kernel pppoatm functionality, or use any kernel modules. I do notice it does 
> a system ("/sbin/modprobe pppoatm"); but this is definitely not required; I'm 
> speaking to you from a speedtouch DSL connection, no module loaded or 
> compiled in, no ATM support in the kernel.

Then you're not using the pppoatm plugin; you needn't bother applying
that patch. You're probably just using the pseudo-tty hack.

-- 
dwmw2

