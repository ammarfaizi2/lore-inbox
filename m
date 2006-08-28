Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWH1RVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWH1RVU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 13:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWH1RVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 13:21:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48857 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750722AbWH1RVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 13:21:19 -0400
Date: Mon, 28 Aug 2006 10:20:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: Linux v2.6.18-rc5
Message-Id: <20060828102030.96084a3f.akpm@osdl.org>
In-Reply-To: <1156752519.29250.47.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
	<20060827231421.f0fc9db1.akpm@osdl.org>
	<200608280925.30600.ak@suse.de>
	<1156752519.29250.47.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2006 10:08:39 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 2006-08-28 at 09:25 +0200, Andi Kleen wrote:
> > On Monday 28 August 2006 08:14, Andrew Morton wrote:
> > 
> > > From: Andi Kleen <ak@suse.de>
> > > Subject: Futex BUG in 2.6.18rc2-git7
> > 
> > I don't think I saw a fix for that, but Thomas and Ingo should know.
> 
> You should know too :)
> 
> 	tglx
> 
> 
> -------- Forwarded Message --------
> From: Olaf Hering <olaf@aepfle.de>
> To: Andi Kleen <ak@suse.de>
> Cc: Olaf Hering <olaf@aepfle.de>, Thomas Gleixner <tglx@linutronix.de>,
> mingo@elte.hu
> Subject: Re: Futex BUG in 2.6.18rc2-git7
> Date: Sat, 5 Aug 2006 10:07:14 +0200
> 
> On Sat, Aug 05, 2006 at 01:09:54AM +0200, Andi Kleen wrote:
> > On Friday 04 August 2006 22:26, Olaf Hering wrote:
> > > On Fri, Aug 04, 2006 at 10:12:15PM +0200, Thomas Gleixner wrote:
> > > 
> > > > Is the glibc the latest CVS version ?
> > > 
> > > Its a snapshot from 2006073023.
> > 
> > Olaf, wagner is running that kernel+Thomas' patch now (although I 
> > didn't think any compat was involved) now. Can you please restart
> > the glibc test?
> 
> This patch fixes it, also the ppc32 and ppc64 glibc make check.

Did this fix get merged?
