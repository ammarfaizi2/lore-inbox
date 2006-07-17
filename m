Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWGQORb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWGQORb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 10:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWGQORb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 10:17:31 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:9353 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750794AbWGQORa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 10:17:30 -0400
Date: Mon, 17 Jul 2006 16:17:20 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Uwe Bugla <uwe.bugla@gmx.de>
cc: johnstul@us.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Valdis.Kletnieks@vt.edu
Subject: Re: Re: i686 hang on boot in userspace
In-Reply-To: <20060717133809.150390@gmx.net>
Message-ID: <Pine.LNX.4.64.0607171605500.6761@scrub.home>
References: <20060714150418.120680@gmx.net> <Pine.LNX.4.64.0607171242440.6761@scrub.home>
 <20060717133809.150390@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Jul 2006, Uwe Bugla wrote:

> I have compared 18-rc1-mm1 and 18-rc1-mm2.
> mm2 contains a patch for timer.c owning almost twice as many hunks than mm1.
> In so far I was sure it was a timer.c issue.

You're still guessing, a lot more things changed between 18-rc1-mm1 and 
18-rc1-mm2. It's rather unlikely that the timer changes fixed your 
problem. You might want to try to revert 
ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm2/broken-out/improve-timekeeping-resume-robustness.patch
to see whether the problem is back afterwards.

bye, Roman
