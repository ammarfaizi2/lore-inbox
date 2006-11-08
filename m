Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422702AbWKHTvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422702AbWKHTvi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754659AbWKHTvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:51:38 -0500
Received: from www.osadl.org ([213.239.205.134]:60127 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1754658AbWKHTvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:51:37 -0500
Subject: Re: AMD X2 unsynced TSC fix?
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: sergio@sergiomb.no-ip.org
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, Andi Kleen <ak@suse.de>,
       Lee Revell <rlrevell@joe-job.com>, Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, len.brown@intel.com,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1162945339.4455.12.camel@monteirov>
References: <1161969308.27225.120.camel@mindpipe>
	 <1162009373.26022.22.camel@localhost.localdomain>
	 <1162177848.2914.13.camel@localhost.portugal>
	 <200610301623.14535.ak@suse.de>
	 <1162253008.2999.9.camel@localhost.portugal>
	 <20061030184155.A3790@unix-os.sc.intel.com>
	 <1162345608.2961.7.camel@localhost.portugal>
	 <20061031184411.E3790@unix-os.sc.intel.com>
	 <1162945339.4455.12.camel@monteirov>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 20:53:48 +0100
Message-Id: <1163015628.8335.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 00:22 +0000, Sergio Monteiro Basto wrote:
> I had update bugzilla with dmesg from 2.6.19-RC4-mm2, which already came
> with the latest release of hrtimers, because for the first time I could
> boot without hang on boot, with hrtimers and without notsc boot option.
> But it have a long long oops that maybe could give you some clues.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=6419#c55

This one is a lock dependency problem, which is fixed in -rc5-mm1

	tglx


