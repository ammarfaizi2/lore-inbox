Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTJ2ATu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 19:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTJ2ATu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 19:19:50 -0500
Received: from palrel10.hp.com ([156.153.255.245]:58073 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261827AbTJ2ATs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 19:19:48 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16287.1953.281434.932309@napali.hpl.hp.com>
Date: Tue, 28 Oct 2003 16:19:45 -0800
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gettimeofday resolution seriously degraded in test9
In-Reply-To: <20031028115917.124a76bf.shemminger@osdl.org>
References: <LphK.2Dl.15@gated-at.bofh.it>
	<Lq47.3Go.11@gated-at.bofh.it>
	<LqGL.4zF.11@gated-at.bofh.it>
	<LAPN.1dU.11@gated-at.bofh.it>
	<LGLz.1h2.5@gated-at.bofh.it>
	<ug8yn541c6.fsf@panda.mostang.com>
	<20031028115917.124a76bf.shemminger@osdl.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 28 Oct 2003 11:59:17 -0800, Stephen Hemminger <shemminger@osdl.org> said:

  Stephen> On 28 Oct 2003 11:19:21 -0800
  Stephen> David Mosberger-Tang <David.Mosberger@acm.org> wrote:

  >> >>>>> On Tue, 28 Oct 2003 19:30:13 +0100, Stephen Hemminger <shemminger@osdl.org> said:

  Stephen> This should work better. Patch against 2.6.0-test9

  >> Why not use the time-interpolator interface defined in timex.h?  It
  >> should handle such things without any special hacks.

  Stephen> Because it has not been used yet outside of ia64.  It would
  Stephen> be worth investigating post 2.6.0 if it could be shown to
  Stephen> be as fast and more correct.  Several people have talked
  Stephen> about redoing the existing mess, but now is not the time to
  Stephen> attack this dragon...

OK, I certainly agree that it's not something that should be done in a
rush, so it's definitely post 2.6.0.

	--david
