Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUDSVHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUDSVHm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 17:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUDSVHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 17:07:42 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:5136 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S261884AbUDSVHj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 17:07:39 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: build system broken in 2.6.6rc1 for external modules?
Date: Mon, 19 Apr 2004 23:07:31 +0200
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <200404191956.53184.arekm@pld-linux.org> <20040419205817.GA2090@mars.ravnborg.org>
In-Reply-To: <20040419205817.GA2090@mars.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404192307.31059.arekm@pld-linux.org>
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "maja.beep.pl", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	postmaster@localhost for details.
	Content preview:  Dnia Monday 19 of April 2004 22:58, Sam Ravnborg
	 =?ISO-8859-1?Q?=20napisa=B3:?= > There is currently a glitch that requires you to have
	defined > at least one module in the kernel. net/dummy for example. >
	When next round of patched are in you will not need to build the full >
	kernel either. Great but with 2.6.5 kernel (2.6.4, too. previous
	probably too) I was able to build modules without need to build the
	full kernel. [...] 
	Content analysis details:   (0.0 points, 25.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Monday 19 of April 2004 22:58, Sam Ravnborg napisa³:

> There is currently a glitch that requires you to have defined
> at least one module in the kernel. net/dummy for example.
> When next round of patched are in you will not need to build the full
> kernel either.
Great but with 2.6.5 kernel (2.6.4, too. previous probably too) I was able to 
build modules without need to build the full kernel.

> If you do not want (cannot) build the kernel in the $KERNELSRCDIR
> then you can use:
>
> cd $KERNELSRCDIR
> copy config-up ~/build
> make O=~/build
This will start building kernel for me! I don't want that. I want only few 
external modules to be built.

I'll wait for ,,next round of patches'' anyway.

> cd $MODULEDIR
> make -C KERNELSRCDIR O=~/build M=$PWD
not
make -C KERNELSRCDIR O=~/build M=$PWD modules ?

> Hope this clarifies it.
> 	Sam

Would be nice if that ended in Documentation/modules.txt for example.

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
