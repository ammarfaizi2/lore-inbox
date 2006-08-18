Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWHRQXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWHRQXL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWHRQXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:23:11 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:13459 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751403AbWHRQXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:23:10 -0400
Subject: Re: 2.6.18-rc4-mm1 + hotfix -- Many processes use the sysctl
	system call
From: Lee Revell <rlrevell@joe-job.com>
To: Mattia Dongili <malattia@linux.it>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       "akpm@osdl.org" <akpm@osdl.org>
In-Reply-To: <20060818144626.GA8236@inferi.kami.home>
References: <a44ae5cd0608171541tf2f125dl586f56da6f1b2a41@mail.gmail.com>
	 <1155854702.8796.97.camel@mindpipe>
	 <20060818144626.GA8236@inferi.kami.home>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 12:23:54 -0400
Message-Id: <1155918234.24907.35.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 16:46 +0200, Mattia Dongili wrote:
> On Thu, Aug 17, 2006 at 06:45:01PM -0400, Lee Revell wrote:
> > On Thu, 2006-08-17 at 15:41 -0700, Miles Lane wrote:
> > > My installation of Ubuntu is having trouble with my kernel build
> > > because I disabled support for sysctl:
> > > 
> > > warning: process `ls' used the removed sysctl system call
> > > warning: process `touch' used the removed sysctl system call
> > > warning: process `touch' used the removed sysctl system call
> > > warning: process `evms_activate' used the removed sysctl system call
> > > warning: process `alsactl' used the removed sysctl system call
> > > 
> > > I am curious whether the use of sysctl indicates a problem in these
> > > processes.  What is the benefit of offering disabling sysctl support?
> > 
> > To make the kernel smaller for people who don't need sysctl.
> > Apparently, you need it.
> 
> afaik, they are being fixed (in debian at least):
> http://lists.debian.org/debian-glibc/2006/08/msg00163.html
> 

"fixed"?  Why is sysctl being removed in the middle of a stable kernel
series?!?  I thought the new golden rule was "don't break userspace"?

Lee

