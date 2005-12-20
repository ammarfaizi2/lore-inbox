Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVLTWOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVLTWOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbVLTWOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:14:04 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:1486 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932187AbVLTWOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:14:02 -0500
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
From: Lee Revell <rlrevell@joe-job.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Courtier-Dutton <James@superbug.co.uk>, Adrian Bunk <bunk@stusta.de>,
       Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>,
       mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
In-Reply-To: <Pine.LNX.4.64.0512201248481.4827@g5.osdl.org>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
	 <20051220131810.GB6789@stusta.de>
	 <20051220155216.GA19797@master.mivlgu.local>
	 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org>
	 <20051220191412.GA4578@stusta.de>
	 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org>
	 <43A86B20.1090104@superbug.co.uk>
	 <Pine.LNX.4.64.0512201248481.4827@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 17:17:47 -0500
Message-Id: <1135117067.27101.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 13:03 -0800, Linus Torvalds wrote:
> Forcing (or even just encouraging) people to use loadable modules is
> just horrible. I personally run a kernel with no modules at all: it
> makes for a simpler bootup, and in some situations (embedded) it has
> both security and size advantages. 

With modules it's possible to test a new ALSA version without
recompiling the kernel or even rebooting.  Encouraging people to build
it into the kernel would create a problematic barrier to entry for
debugging.  With the amount of poorly documented hardware we support,
it's essential for preventing driver regressions for users to be able to
easily test the latest ALSA version.  

Lee

