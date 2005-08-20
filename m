Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVHTW1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVHTW1a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 18:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVHTW1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 18:27:30 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:17162 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1750700AbVHTW13
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 18:27:29 -0400
Date: Sat, 20 Aug 2005 17:24:46 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: paulmck@us.ibm.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostdt@goodmis.org>
Subject: Re: 2.6.13-rc6-rt9
Message-ID: <20050820212446.GA9822@ccure.user-mode-linux.org>
References: <20050818060126.GA13152@elte.hu> <1124470574.17311.4.camel@twins> <1124476205.17311.8.camel@twins> <20050819184334.GG1298@us.ibm.com> <1124566045.17311.11.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124566045.17311.11.camel@twins>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2005 at 09:27:25PM +0200, Peter Zijlstra wrote:
> Jeff, could you help us out here?
> What exactly does uml need to get out of the calibrate delay loop?

Interrupts, it's not too demanding :-)

If it's not seeing VTALRM, then it will never leave the calibration loop.

Try stracing it and see what it's getting.

				Jeff
