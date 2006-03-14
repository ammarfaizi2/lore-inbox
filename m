Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbWCNRg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWCNRg4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 12:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbWCNRg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 12:36:56 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:19085 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751542AbWCNRgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 12:36:55 -0500
Subject: Re: does swsusp suck after resume for you? [was Re: Faster
	resuming of suspend technology.]
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
In-Reply-To: <20060314115145.GL10870@elf.ucw.cz>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
	 <20060313113631.GA1736@elf.ucw.cz> <200603132303.18758.kernel@kolivas.org>
	 <200603141613.10915.kernel@kolivas.org> <20060314115145.GL10870@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 12:36:45 -0500
Message-Id: <1142357806.13256.140.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 12:51 +0100, Pavel Machek wrote:
> "we have just
> finished big&ugly memory trashing job, can we get our interactivity
> back"? Like I'd probably cron-scheduled it just after updatedb 

The updatedb problem is STILL not solved?  I remember someone proposed
years ago to have it use fcntl() or fadvise() to tell the kernel that we
are about to read every file on the system and to please not wipe the
cache - I guess this was never done?

Lee

