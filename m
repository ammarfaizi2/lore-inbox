Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbUDARyt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 12:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbUDARyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 12:54:49 -0500
Received: from holomorphy.com ([207.189.100.168]:50350 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263000AbUDARyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 12:54:45 -0500
Date: Thu, 1 Apr 2004 09:54:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       kenneth.w.chen@intel.com, Chris Wright <chrisw@osdl.org>
Subject: Re: disable-cap-mlock
Message-ID: <20040401175436.GI791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
	kenneth.w.chen@intel.com, Chris Wright <chrisw@osdl.org>
References: <20040401135920.GF18585@dualathlon.random> <1080841071.25431.155.camel@moss-spartans.epoch.ncsc.mil> <20040401174405.GG791@holomorphy.com> <200404011952.29724@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404011952.29724@WOLK>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 April 2004 19:44, William Lee Irwin III wrote:
>> I'm aware it does some very unintelligent things to the security model,
>> e.g. anyone with fs-level access to these things can basically escalate
>> their capabilities to "everything". Maybe some kind of big fat warning
>> is in order.

On Thu, Apr 01, 2004 at 07:52:29PM +0200, Marc-Christian Petersen wrote:
> hmm, maybe a /proc/sys/capability/lock and if set to 1 you can't
> change any of the sysctl variables, even root should not be allowed
> to change lock back, until you do a reboot. Practical?
> ciao, Marc

Feasible, though it's an open question as to how many hoops we should
jump through to prevent people from shooting themselves in the foot.

Maybe Steven could recommend adjustments and/or give some idea as to
whether the above would be useful.


-- wli
