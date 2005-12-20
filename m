Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVLTWJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVLTWJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVLTWJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:09:36 -0500
Received: from ns2.suse.de ([195.135.220.15]:25768 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932165AbVLTWJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:09:35 -0500
Date: Tue, 20 Dec 2005 23:09:32 +0100
From: Olaf Hering <olh@suse.de>
To: Olof Johansson <olof@lixom.net>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: console on POWER4 not working with 2.6.15
Message-ID: <20051220220932.GA29092@suse.de>
References: <20051220204530.GA26351@suse.de> <20051220214525.GB7428@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051220214525.GB7428@pb15.lixom.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Dec 20, Olof Johansson wrote:

> On Tue, Dec 20, 2005 at 09:45:30PM +0100, Olaf Hering wrote:
> > The connection of ttyS0 to /dev/console doesnt seem to work anymore mit
> > 2.6.15-rc5+6 on a POWER4 p630 in fullsystempartition mode, no HMC
> > connected. It works with 2.6.14.4.
> > I tested 2.6.15-rc6 arch/powerpc/configs/ppc64_defconfig.
> 
> It seems to have been broken a while: According to test.kernel.org (last
> machine in the matrix is an SMP mode p650), it broke between 2.6.14-git2
> and 2.6.14-git3. Console output can be found in:
> 

I remember someone mentioned that a 43p 150 did not boot if the keyboard
is connected. Will try that tomorrow. The git2-3 diff is huge, so maybe
this hint helps.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
