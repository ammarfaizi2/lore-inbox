Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268971AbUHMEpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268971AbUHMEpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 00:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268970AbUHMEpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 00:45:06 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11405 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268971AbUHMEog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 00:44:36 -0400
Subject: Re: Linux 2.6.8-rc4 [RESEND] via-rhine: Really call
	rhine_power_init()
From: Lee Revell <rlrevell@joe-job.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040810083350.GA23771@k3.hellgate.ch>
References: <Pine.LNX.4.58.0408091958450.1839@ppc970.osdl.org>
	 <20040810083350.GA23771@k3.hellgate.ch>
Content-Type: text/plain
Message-Id: <1092372311.3450.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 00:45:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 04:33, Roger Luethi wrote:
> This is my third and last attempt to get this fix merged for 2.6.8.
> 
> Without this patch, mainline via-rhine cannot wake the chip if some other
> driver puts it to D3. The problem has hit quite a few people already.
> 

Argh, this is *still* not fixed in -rc4!  How loud does one have to yell
to get an absolutely FATAL bug with a trivial fix merged?

Lots of people spent lots of time trying to track this bug down.  I
would hate to think all that time was wasted.  *Please* apply Roger's
patch, or many people will be unable to upgrade to 2.6.8.  I am getting
tired of replacing via-rhine.c with the version from -mm every time I
compile a new kernel just to keep my network card working.

Lee

