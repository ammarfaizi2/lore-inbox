Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWH1IFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWH1IFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWH1IFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:05:15 -0400
Received: from www.osadl.org ([213.239.205.134]:19848 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751413AbWH1IFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:05:13 -0400
Subject: Re: Linux v2.6.18-rc5
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@elte.hu
In-Reply-To: <200608280925.30600.ak@suse.de>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
	 <20060827231421.f0fc9db1.akpm@osdl.org>  <200608280925.30600.ak@suse.de>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 10:08:39 +0200
Message-Id: <1156752519.29250.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 09:25 +0200, Andi Kleen wrote:
> On Monday 28 August 2006 08:14, Andrew Morton wrote:
> 
> > From: Andi Kleen <ak@suse.de>
> > Subject: Futex BUG in 2.6.18rc2-git7
> 
> I don't think I saw a fix for that, but Thomas and Ingo should know.

You should know too :)

	tglx


-------- Forwarded Message --------
From: Olaf Hering <olaf@aepfle.de>
To: Andi Kleen <ak@suse.de>
Cc: Olaf Hering <olaf@aepfle.de>, Thomas Gleixner <tglx@linutronix.de>,
mingo@elte.hu
Subject: Re: Futex BUG in 2.6.18rc2-git7
Date: Sat, 5 Aug 2006 10:07:14 +0200

On Sat, Aug 05, 2006 at 01:09:54AM +0200, Andi Kleen wrote:
> On Friday 04 August 2006 22:26, Olaf Hering wrote:
> > On Fri, Aug 04, 2006 at 10:12:15PM +0200, Thomas Gleixner wrote:
> > 
> > > Is the glibc the latest CVS version ?
> > 
> > Its a snapshot from 2006073023.
> 
> Olaf, wagner is running that kernel+Thomas' patch now (although I 
> didn't think any compat was involved) now. Can you please restart
> the glibc test?

This patch fixes it, also the ppc32 and ppc64 glibc make check.


