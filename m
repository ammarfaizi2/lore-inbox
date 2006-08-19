Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751616AbWHSAtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbWHSAtG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 20:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbWHSAtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 20:49:05 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:34701 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751616AbWHSAtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 20:49:04 -0400
Subject: Re: 2.6.18-rc4-mm1 + hotfix -- Many processes use the sysctl
	system call
From: Lee Revell <rlrevell@joe-job.com>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Gabor Gombas <gombasg@sztaki.hu>, Mattia Dongili <malattia@linux.it>,
       Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       "akpm@osdl.org" <akpm@osdl.org>
In-Reply-To: <20060819024020.GD720@slug>
References: <a44ae5cd0608171541tf2f125dl586f56da6f1b2a41@mail.gmail.com>
	 <1155854702.8796.97.camel@mindpipe>
	 <20060818144626.GA8236@inferi.kami.home>
	 <1155918234.24907.35.camel@mindpipe>
	 <20060819003037.GB6440@boogie.lpds.sztaki.hu>  <20060819024020.GD720@slug>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 20:49:03 -0400
Message-Id: <1155948543.2924.101.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-19 at 02:40 +0000, Frederik Deweerdt wrote:
> On Sat, Aug 19, 2006 at 02:30:37AM +0200, Gabor Gombas wrote:
> > On Fri, Aug 18, 2006 at 12:23:54PM -0400, Lee Revell wrote:
> > 
> > > "fixed"?  Why is sysctl being removed in the middle of a stable kernel
> > > series?!?
> > 
> > IMHO the stable series is 2.6.x.y nowadays. 2.6.z (without a fourth
> > number) is more or less what used to be 2.<odd> previously.
> Not to mention we're dealing with a -mm kernel...
> 

Ah, OK - the debian-glibc thread the OP referred to began:

"Starting with 2.6.18, the official kernels do not have the sysctl 
syscall anymore (http://lkml.org/lkml/2006/7/15/54) or rather it has 
been replaced by a dummy syscall that always fail and print a message 
in the log, and thus the sysctl() function will not work anymore."

However the referenced link is about an -mm kernel.

Sorry for the noise.

Lee


