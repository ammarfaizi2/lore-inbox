Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVBOPQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVBOPQY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 10:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVBOPQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 10:16:23 -0500
Received: from mail.suse.de ([195.135.220.2]:46246 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261750AbVBOPQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 10:16:07 -0500
Message-ID: <4212121B.807@suse.de>
Date: Tue, 15 Feb 2005 16:15:39 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: Prakash Punnoor <prakashp@arcor.de>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>	 <20050211011609.GA27176@suse.de>	 <1108354011.25912.43.camel@krustophenia.net>	 <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de>	 <1108422240.28902.11.camel@krustophenia.net>	 <20050214231605.GA13969@suse.de> <1108423715.32293.2.camel@krustophenia.net>
In-Reply-To: <1108423715.32293.2.camel@krustophenia.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

> That init scripts with no interdependencies are run sequentially rather
> than in parallel.
> 
> There was an article from IBM a while back with a neat hack that used a
> parallel make to fire off groups of init scripts in parallel.  I would
> expect more interest in this from the distros.

You can boot a SUSE 9.2 with parallel init scripts (default AFAIR),
sequential init scripts and with a Makefile based solution. "Normal"
(not Makefile based) parallel booting is possible much longer on SUSE,
at least since 9.0 IIRC.
And guess what? "Parallel booting" alone, regardless of the mechanism
does not make much of a difference for the boot time.

Stefan
