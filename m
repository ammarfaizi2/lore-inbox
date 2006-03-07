Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWCGFMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWCGFMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 00:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWCGFMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 00:12:08 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:3845 "EHLO sorrow.cyrius.com")
	by vger.kernel.org with ESMTP id S1750838AbWCGFMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 00:12:06 -0500
Date: Tue, 7 Mar 2006 05:11:52 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: de2104x: interrupts before interrupt handler is registered
Message-ID: <20060307051152.GA1244@deprecation.cyrius.com>
References: <20060305180757.GA22121@deprecation.cyrius.com> <20060305185948.GA24765@electric-eye.fr.zoreil.com> <20060306143512.GI23669@deprecation.cyrius.com> <20060306191706.GA6947@deprecation.cyrius.com> <20060306211745.GD15728@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306211745.GD15728@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Francois Romieu <romieu@fr.zoreil.com> [2006-03-06 22:17]:
> Not sure about this one, but...

It seems to help.  It's hard to say for sure because I don't have a
foolproof way to reproduce this panic.  It _usually_ occurs after
copying a few hundred MB but there's no clear trigger.  I've now copied
a few GB around using a kernel with your patch and it hasn't crashed.
-- 
Martin Michlmayr
http://www.cyrius.com/
