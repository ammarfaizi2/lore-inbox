Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbWHQWoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWHQWoX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 18:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWHQWoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 18:44:23 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:40397 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030304AbWHQWoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 18:44:22 -0400
Subject: Re: 2.6.18-rc4-mm1 + hotfix -- Many processes use the sysctl
	system call
From: Lee Revell <rlrevell@joe-job.com>
To: Miles Lane <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "akpm@osdl.org" <akpm@osdl.org>
In-Reply-To: <a44ae5cd0608171541tf2f125dl586f56da6f1b2a41@mail.gmail.com>
References: <a44ae5cd0608171541tf2f125dl586f56da6f1b2a41@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 18:45:01 -0400
Message-Id: <1155854702.8796.97.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 15:41 -0700, Miles Lane wrote:
> My installation of Ubuntu is having trouble with my kernel build
> because I disabled support for sysctl:
> 
> warning: process `ls' used the removed sysctl system call
> warning: process `touch' used the removed sysctl system call
> warning: process `touch' used the removed sysctl system call
> warning: process `evms_activate' used the removed sysctl system call
> warning: process `alsactl' used the removed sysctl system call
> 
> I am curious whether the use of sysctl indicates a problem in these
> processes.  What is the benefit of offering disabling sysctl support?

To make the kernel smaller for people who don't need sysctl.
Apparently, you need it.

Lee

