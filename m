Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbWGHWzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWGHWzK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 18:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbWGHWzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 18:55:09 -0400
Received: from 142.163.233.220.exetel.com.au ([220.233.163.142]:6600 "EHLO
	idefix.homelinux.org") by vger.kernel.org with ESMTP
	id S1030415AbWGHWzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 18:55:07 -0400
Subject: Re: Suspend to RAM regression tracked down
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Dave Jones <davej@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk
In-Reply-To: <20060708062345.GB3356@redhat.com>
References: <1151837268.5358.10.camel@idefix.homelinux.org>
	 <44A80B20.1090702@goop.org> <1152271537.5163.4.camel@idefix.homelinux.org>
	 <20060707162152.GB3223@redhat.com>
	 <1152312530.14453.16.camel@idefix.homelinux.org>
	 <20060708062345.GB3356@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
Date: Sun, 09 Jul 2006 08:55:02 +1000
Message-Id: <1152399303.14453.29.camel@idefix.homelinux.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you're prepared to play around with 'git bisect' a little, it shouldn't
> take that many iterations, as you've already narrowed it down quite a lot.
> 
> $ git bisect start drivers/cpufreq/cpufreq_ondemand.c
> $ git bisect bad
> $ git bisect good v2.6.12-rc5
> 
> should get you most of the way there.
> 
> http://www.kernel.org/pub/software/scm/git/docs/git-bisect.html
> has more info.

Could you give me a bit more info, since I've never used git before (I
only downloaded the git snapshots)? Also, if I understand correctly,
cpufreq_ondemand.c is the only file that could cause the problem. Is
that right? Also, is it possible to use an old version of it on a new
kernel?

	Jean-Marc
