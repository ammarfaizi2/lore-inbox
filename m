Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422653AbWAMNGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422653AbWAMNGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 08:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422657AbWAMNGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 08:06:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58333 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422653AbWAMNGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 08:06:17 -0500
Subject: Re: [patch 00/62] sem2mutex: -V1
From: Arjan van de Ven <arjan@infradead.org>
To: Duncan Sands <baldrick@free.fr>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Jes Sorensen <jes@trained-monkey.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
In-Reply-To: <200601131400.00279.baldrick@free.fr>
References: <20060113124402.GA7351@elte.hu>
	 <200601131400.00279.baldrick@free.fr>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 14:06:11 +0100
Message-Id: <1137157571.2936.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 13:59 +0100, Duncan Sands wrote:
> > this patch-queue converts 66% of all semaphore users in 2.6.15-git9 to 
> > mutexes.
> 
> Hi Ingo, the changes to drivers/usb/atm/usbatm.[ch] conflict with a bunch
> of patches I just sent to Greg KH.  How do you plan to handle this kind of
> thing?  If you like, I can tweak this part of your patch so it applies on
> top of mine, and push it to Greg.


ideally you merge the patch into your queue and send it (via gregkh) on
its way to the final kernel.org merge.

This queue isn't meant to be "this is all going direct to linus
bypassing everyone"; we're trying to get as much as possible sent via
the maintainers. So if you as maintainer want to pick up a patch, we're
very happy about that!

Greetings,
   Arjan van de Ven

