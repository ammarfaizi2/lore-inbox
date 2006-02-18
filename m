Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWBRT1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWBRT1d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 14:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWBRT1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 14:27:33 -0500
Received: from quechua.inka.de ([193.197.184.2]:20959 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932124AbWBRT1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 14:27:32 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: How to find the CPU usage of a process
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <a36005b50602181055n454c446aoed83ea21baaf1a67@mail.gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1FAXjn-0001V7-00@calista.inka.de>
Date: Sat, 18 Feb 2006 20:27:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@gmail.com> wrote:
> That's after the fact.  Programs which want to get the information
> while running can use the CPU clocks:
> 
>  struct timespec ts;
>  if (clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts) != 0)
>    fatal("cannot get CPU time");
>  /* result is in TS */

But thats only for yourself, right?

Gruss
Bernd
