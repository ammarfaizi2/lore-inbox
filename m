Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVBJSly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVBJSly (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 13:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVBJSly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 13:41:54 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:1388 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261193AbVBJSlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 13:41:50 -0500
Date: Thu, 10 Feb 2005 19:42:20 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Michael Renzmann <mrenzmann@web.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: How to retrieve version from kernel source (the right way)?
Message-ID: <20050210184218.GA9338@mars.ravnborg.org>
Mail-Followup-To: Michael Renzmann <mrenzmann@web.de>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <4209C71F.9040102@web.de> <35297.194.237.142.7.1107985448.squirrel@194.237.142.7> <420B07FA.7050309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420B07FA.7050309@web.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 08:06:34AM +0100, Michael Renzmann wrote:
> Hi.
> 
> Sam Ravnborg wrote:
> >>But... what is the right way to do this?
> >I think you are looking for:
> >make kernelrelease
> 
> otaku@gimli linux-2.6.10 $ make kernelrelease
> make: *** No rule to make target `kernelrelease'.  Stop.
> otaku@gimli linux-2.6.10 $ cd ..
> otaku@gimli src $ cd linux-2.4.28
> otaku@gimli linux-2.4.28 $ make kernelrelease
> make: *** No rule to make target `kernelrelease'.  Stop.
> otaku@gimli linux-2.4.28 $
> 
> I don't think this will help.
> 
> Including the kernel's Makefile also is no option, I think ("rulespace 
> pollution").

I works with the 2.6 kernel.

	Sam
