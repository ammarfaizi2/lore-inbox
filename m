Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275283AbTHGLdD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 07:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275289AbTHGLdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 07:33:03 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:39042 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S275283AbTHGLdB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 07:33:01 -0400
Subject: Re: 2.5/2.6 PCMCIA Issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <200308060711.h767B0I19677@mail.osdl.org>
References: <20030804232204.GA21763@nasledov.com>
	 <20030805144453.A8914@flint.arm.linux.org.uk>
	 <20030806045627.GA1625@nasledov.com>
	 <200308060559.h765xhI05860@mail.osdl.org>
	 <20030805234212.081c0493.akpm@osdl.org>
	 <200308060711.h767B0I19677@mail.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060255748.3123.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 12:29:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-06 at 08:11, Linus Torvalds wrote:
> Anyway, I suspect that i82365 should just quit by default if a yenta
> controller has already been found. I can't imagine that you'd have
> both a yenta controller _and_ an i82365 controller, since there are
> actually some port overlaps there (ie yenta should already register
> the i82365 legacy ports).

I have such a box, it worked in 2.4 (the i82365 is at different ports)

