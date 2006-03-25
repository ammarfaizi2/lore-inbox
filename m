Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWCYHGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWCYHGD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 02:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWCYHGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 02:06:03 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:35078 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750777AbWCYHGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 02:06:02 -0500
Date: Sat, 25 Mar 2006 08:05:44 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: evt@texelsoft.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: what's the right way to do this in 2.6?
Message-ID: <20060325070544.GA13259@mars.ravnborg.org>
References: <W433413418255631143243608@webmail13>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <W433413418255631143243608@webmail13>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 11:40:08PM +0000, evt@texelsoft.com wrote:
> I have two modules that need to share a common utility library. What
> I'd like to do is make the library into a .a and link each module to it.
> 'Twould be also nice if the modules had a dependency so the library
> got built automatically. Thanks for any advice.
Drop the library idea and create a third module.
That's how this is done in several places in the kernel with success.

See Documentation/kbuild/* for how to deal with more than one module.

	Sam
