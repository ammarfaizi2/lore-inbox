Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbUDARxj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 12:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbUDARxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 12:53:25 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:5641 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263014AbUDARwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 12:52:13 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: disable-cap-mlock
Date: Thu, 1 Apr 2004 19:52:29 +0200
User-Agent: KMail/1.6.1
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>, kenneth.w.chen@intel.com,
       Chris Wright <chrisw@osdl.org>
References: <20040401135920.GF18585@dualathlon.random> <1080841071.25431.155.camel@moss-spartans.epoch.ncsc.mil> <20040401174405.GG791@holomorphy.com>
In-Reply-To: <20040401174405.GG791@holomorphy.com>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404011952.29724@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 April 2004 19:44, William Lee Irwin III wrote:

Hi,

> > What prevents any uid 0 process from changing these sysctl settings
> > (aside from SELinux, if you happen to use it and configure the policy
> > accordingly)?

> I'm aware it does some very unintelligent things to the security model,
> e.g. anyone with fs-level access to these things can basically escalate
> their capabilities to "everything". Maybe some kind of big fat warning
> is in order.

hmm, maybe a /proc/sys/capability/lock and if set to 1 you can't change any of 
the sysctl variables, even root should not be allowed to change lock back, 
until you do a reboot. Practical?

ciao, Marc
