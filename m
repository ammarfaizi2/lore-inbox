Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752577AbVHGTDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbVHGTDS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 15:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbVHGTDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 15:03:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:23502 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1752577AbVHGTDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 15:03:17 -0400
Date: Sun, 7 Aug 2005 21:02:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-pm@osdl.org,
       Martin =?iso-8859-2?Q?MOKREJ=A9?= 
	<mmokrejs@ribosome.natur.cuni.cz>,
       Zlatko Calusic <zlatko.calusic@iskon.hr>,
       =?iso-8859-2?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@24x7linux.com>,
       john@illhostit.com, sjordet@gmail.com, fastboot@lists.osdl.org,
       linux-kernel@24x7linux.com, ncunningham@cyclades.com,
       Greg KH <greg@kroah.com>
Subject: Re: FYI: device_suspend(...) in kernel_power_off().
Message-ID: <20050807190222.GF1024@openzaurus.ucw.cz>
References: <dny87s6oe9.fsf@magla.zg.iskon.hr> <m1r7dk82a4.fsf@ebiederm.dsl.xmission.com> <42E8439E.9030103@ribosome.natur.cuni.cz> <20050727193911.2cb4df88.akpm@osdl.org> <42F121CD.5070903@ribosome.natur.cuni.cz> <20050803200514.3ddb8195.akpm@osdl.org> <20050805140837.GA5556@localhost> <42F52AC5.1060109@ribosome.natur.cuni.cz> <m1hde2xy74.fsf@ebiederm.dsl.xmission.com> <m13bplykt3.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m13bplykt3.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> There as been a fair amount of consensus that calling
> device_suspend(...) in the reboot path was inappropriate now, because
> the device suspend code was too immature.   With this latest
> piece of evidence it seems to me that introducing device_suspend(...)
> in kernel_power_off, kernel_halt, kernel_reboot, or kernel_kexec
> can never be appropriate.

Code is not ready now => it can never be fixed? Thats quite a strange
conclusion to make.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

