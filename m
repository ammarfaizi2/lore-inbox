Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWIYM4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWIYM4S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 08:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWIYM4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 08:56:18 -0400
Received: from sigint.cs.purdue.edu ([128.10.2.82]:226 "EHLO
	sigint.cs.purdue.edu") by vger.kernel.org with ESMTP
	id S1751153AbWIYM4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 08:56:17 -0400
Date: Mon, 25 Sep 2006 08:56:16 -0400
From: linux@sigint.cs.purdue.edu
To: Roman Glebov <sleon@sleon.dyndns.org>, linux-kernel@vger.kernel.org
Cc: Wakko Warner <wakko@animx.eu.org>
Subject: Re: megaraid question
Message-ID: <20060925125616.GA15591@sigint.cs.purdue.edu>
References: <20060925012909.A56E52963F@sleon.dyndns.org> <20060925015126.GA8764@animx.eu.org> <200609250417.41995.sleon@sleon.dyndns.org> <20060925105908.GA9897@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060925105908.GA9897@animx.eu.org>
X-Disclaimer: Any similarity to an opinion of Purdue is purely coincidental
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 06:59:08AM -0400, Wakko Warner wrote:
> Roman Glebov wrote:
> > 
> > Also i was told that there is a binary monitoring tool from lsi-logic page.
> > 
> > But will it work with open source driver?
> 
> I'm not sure about the program from LSI, but the one from Dell seems to work
> with any megaraid controller (the one I do have happens to be a dell
> megaraid card).  The program I used from that package looks very similar to
> the bios configuration tool and you can change disk layouts from within the
> program while still in linux.

The program from Dell is the same program you get from LSI.  Yes, it does
work with the kernel's "new generation" megaraid driver.  Just make sure
/dev/megadev0 is present.
