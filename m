Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266683AbUGLBck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUGLBck (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 21:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUGLBck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 21:32:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:30674 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266683AbUGLBci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 21:32:38 -0400
Subject: Re: 2.6.7 - Oops when unsuspending on PPC iBook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: The Doctor What <docwhat@gerf.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040709233608.GC21865@gerf.org>
References: <20040709233608.GC21865@gerf.org>
Content-Type: text/plain
Message-Id: <1089595978.1876.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 11 Jul 2004 20:32:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-09 at 18:36, The Doctor What wrote:
> See the attached config and oops.  I didn't think I had i2c compiled
> in, but I guess I do. :-/
> 
> It's a stock 2.6.7 kernel except for the orinoco/hermes/airport
> drivers.  I can test this without them, if someone really thinks
> that that is the problem.
> 
> Any thoughts?  I'm having a problem getting my iBook (blueberry
> 300Mhz iBook1) to suspend correctly (the display light doesn't go
> off).  This use to work.  I'd prefer not to go back to 2.4...

The ooops backtrace isn't very readable... Do you use Alsa or
dmasound ? It could be an alsa problem...

Ben.


