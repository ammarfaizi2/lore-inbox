Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbWHROrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbWHROrO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 10:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbWHROrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 10:47:14 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:38824 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1030447AbWHROrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 10:47:13 -0400
Date: Fri, 18 Aug 2006 16:46:26 +0200
From: Mattia Dongili <malattia@linux.it>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       "akpm@osdl.org" <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm1 + hotfix -- Many processes use the sysctl system call
Message-ID: <20060818144626.GA8236@inferi.kami.home>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Miles Lane <miles.lane@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"akpm@osdl.org" <akpm@osdl.org>
References: <a44ae5cd0608171541tf2f125dl586f56da6f1b2a41@mail.gmail.com> <1155854702.8796.97.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155854702.8796.97.camel@mindpipe>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.18-rc4-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 06:45:01PM -0400, Lee Revell wrote:
> On Thu, 2006-08-17 at 15:41 -0700, Miles Lane wrote:
> > My installation of Ubuntu is having trouble with my kernel build
> > because I disabled support for sysctl:
> > 
> > warning: process `ls' used the removed sysctl system call
> > warning: process `touch' used the removed sysctl system call
> > warning: process `touch' used the removed sysctl system call
> > warning: process `evms_activate' used the removed sysctl system call
> > warning: process `alsactl' used the removed sysctl system call
> > 
> > I am curious whether the use of sysctl indicates a problem in these
> > processes.  What is the benefit of offering disabling sysctl support?
> 
> To make the kernel smaller for people who don't need sysctl.
> Apparently, you need it.

afaik, they are being fixed (in debian at least):
http://lists.debian.org/debian-glibc/2006/08/msg00163.html

-- 
mattia
:wq!
