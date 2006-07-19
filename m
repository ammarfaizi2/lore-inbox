Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWGSP3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWGSP3S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 11:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWGSP3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 11:29:18 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:58277 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964872AbWGSP3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 11:29:17 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: George Nychis <gnychis@cmu.edu>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
Date: Wed, 19 Jul 2006 17:28:44 +0200
User-Agent: KMail/1.9.3
Cc: Jeff Chua <jchua@fedex.com>, lkml <linux-kernel@vger.kernel.org>
References: <30DF6C25102A6E4BBD30B26C4EA1DCCC0162E099@MEMEXCH10V.corp.ds.fedex.com> <200607190005.02351.rjw@sisk.pl> <44BE4B33.6090009@cmu.edu>
In-Reply-To: <44BE4B33.6090009@cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607191728.44158.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 July 2006 17:09, George Nychis wrote:
> Okay, I was missing that, thanks
> 
> So, i suspended to disk the first time and it seemed to suspend
> properly, then I hit the power button on the thinkpad and it took me to
> the thinkpad screen, back to grub, and booted the OS from the beginning.
>  Did I resume the wrong way?

After suspend you have to boot _exactly_ the same kernel the suspend image
has been created for.  Otherwise it won't read the image.

Greetings,
Rafael
