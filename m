Return-Path: <linux-kernel-owner+w=401wt.eu-S932408AbWLPUWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWLPUWW (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 15:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWLPUWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 15:22:21 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:59968 "HELO
	mustang.oldcity.dca.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932408AbWLPUWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 15:22:21 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 15:22:20 EST
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: =?ISO-8859-1?Q?Hans-J=FCrgen?= Koch <hjk@linutronix.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0612141756110.12730@yvahk01.tjqt.qr>
References: <20061213195226.GA6736@kroah.com>
	 <Pine.LNX.4.64.0612131252300.5718@woody.osdl.org>
	 <200612140949.43270.duncan.sands@math.u-psud.fr>
	 <200612141056.03538.hjk@linutronix.de>
	 <Pine.LNX.4.61.0612141756110.12730@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 16 Dec 2006 15:13:52 -0500
Message-Id: <1166300032.17059.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 18:02 +0100, Jan Engelhardt wrote:
> On Dec 14 2006 10:56, Hans-Jürgen Koch wrote:
> >
> >A small German manufacturer produces high-end AD converter cards. He sells
> >100 pieces per year, only in Germany and only with Windows drivers. He would
> >now like to make his cards work with Linux. He has two driver programmers
> >with little experience in writing Linux kernel drivers. What do you tell him?
> >Write a large kernel module from scratch? Completely rewrite his code 
> >because it uses floating point arithmetics?
> 
> They use floating point in (Windows) kernelspace? Oh my.

Yes, definitely.  For example lots of Windows sound drivers do AC3
decoding in kernelspace.  Of course the vendors usually lie and say it's
done in hardware...

Lee

