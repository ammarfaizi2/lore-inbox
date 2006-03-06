Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWCFTVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWCFTVG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWCFTVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:21:06 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:17423 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S932340AbWCFTVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:21:04 -0500
Date: Mon, 6 Mar 2006 19:17:06 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: de2104x: interrupts before interrupt handler is registered
Message-ID: <20060306191706.GA6947@deprecation.cyrius.com>
References: <20060305180757.GA22121@deprecation.cyrius.com> <20060305185948.GA24765@electric-eye.fr.zoreil.com> <20060306143512.GI23669@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306143512.GI23669@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Michlmayr <tbm@cyrius.com> [2006-03-06 14:35]:
> Thanks a lot for your quick response, Francois.  I can confirm that
> this patch fixes the problem for me.

There's another interrupt related bug in the driver, though.  I
sometimes get a kernel panic when rsycing several 100 megs of data
across the LAN.  A picture showing the call trace can be found at
http://www.cyrius.com/tmp/de2104x_panic.jpg

-- 
Martin Michlmayr
http://www.cyrius.com/
