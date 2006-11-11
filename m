Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947246AbWKKOLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947246AbWKKOLY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 09:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947248AbWKKOLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 09:11:24 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:57404 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1947246AbWKKOLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 09:11:23 -0500
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=GMQ5WV/o7Aq2nRZmPnUU5D60E42V263RFzW8DF5qGBHblWoGUYNublG1bQmoaiYx0KJbfM8QptWNGo1JninpQ3oGnZwk9N57Ev3fr+iK2d2U6x0uBl7TizO//jY4ZcBo;
X-IronPort-AV: i="4.09,413,1157346000"; 
   d="scan'208"; a="117016416:sNHT27613422"
Date: Sat, 11 Nov 2006 08:11:26 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Olaf Hering <olaf@aepfle.de>, jurriaan <thunder7@xs4all.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: wanted: more informative message if root device can't be found/mounted
Message-ID: <20061111141126.GB16744@lists.us.dell.com>
References: <20061111085200.GA4167@amd64.of.nowhere> <20061111114436.GA10020@aepfle.de> <1163246257.3293.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163246257.3293.11.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2006 at 12:57:37PM +0100, Arjan van de Ven wrote:
> On Sat, 2006-11-11 at 12:44 +0100, Olaf Hering wrote:
> > On Sat, Nov 11, jurriaan wrote:
> > 
> > > kernel panic - unable to mount root device 09:02
> > 
> > These numbers are the root cause.
> > Use mount by filesystem UUID. On-disk content does unlikely change.
> > And if it does, you have to reconfigure the bootloader anyway.
> > 
> > All this luxury doesnt belong into the kernel.
> 
> one thing that we should consider is to not panic(). Panic() tends to
> cause the backscroll capability to go away.. which is rather useful to
> see what went wrong for this scenario...

+1.  To the untrained eye, "kernel panic" gets filed as a Sev 1 issue
by end users and testers alike, when most often it's a system
configuration error rather than a kernel bug.

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
