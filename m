Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbTDNJ5m (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 05:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTDNJ5m (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 05:57:42 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:52693 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id S262941AbTDNJ5l (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 05:57:41 -0400
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1050314423.5574.65.camel@zion.wanadoo.fr>
References: <1050314423.5574.65.camel@zion.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050315066.5574.71.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Apr 2003 12:11:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> I also noticed the IDE PM code is hopeless, I'll try to hack something
> that works at least as good than what I had in the pmac 2.4 code, and
> the fbdev PM code is almost unexisting (I need at least a way for the
> driver to tell the PM layer not to mess with the framebuffer once the
                     ^^
> driver is asleep). I'll hack something as well.

 ... to tell the fbdev layer ... you will have corrected yourself ;)

Ben.
