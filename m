Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWFPJY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWFPJY2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 05:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWFPJY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 05:24:28 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:46242 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1750839AbWFPJY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 05:24:27 -0400
Date: Fri, 16 Jun 2006 11:23:46 +0200
From: Voluspa <lista1@comhem.se>
To: Lee Revell <rlrevell@joe-job.com>
Cc: randy.dunlap@oracle.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       len.brown@intel.com, rdreier@cisco.com, mingo@elte.hu
Subject: Re: [UBUNTU:acpi/ec] Use semaphore instead of spinlock
Message-Id: <20060616112346.1d2050d0.lista1@comhem.se>
In-Reply-To: <1150388824.2925.105.camel@mindpipe>
References: <20060615010850.3d375fa9.lista1@comhem.se>
	<4490B48E.5060304@oracle.com>
	<20060615130336.176f527c.lista1@comhem.se>
	<1150388824.2925.105.camel@mindpipe>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2006 12:27:03 -0400 Lee Revell wrote:
> On Thu, 2006-06-15 at 13:03 +0200, Voluspa wrote:
> > On Wed, 14 Jun 2006 18:14:54 -0700 Randy Dunlap wrote:
> > > updated version:
> > 
> > As a user, it's great if this fixes people's keyboards and mice. But it's
> > not a panacea. Gkrellm reads CPU temperatures from
> > /proc/acpi/thermal_zone/*/temperature and that disturbs a time-critical
> > application like mplayer, both when reading normal video and hacked mms:
> > sound streams (ogg sound is OK, though):
> > 
> 
> It would be helpful to analyze this with Ingo's latency tracing patch.

Do you mean proper in relation to ubuntu-patched, or just proper? And, hmmm,
I do read a lot of archived lkml threads, but latency tracing patch... Is
it buried in the -rt set?

Mvh
Mats Johannesson
--
