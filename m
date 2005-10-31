Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbVJaQgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVJaQgd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 11:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVJaQgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 11:36:33 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24803 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932455AbVJaQgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 11:36:33 -0500
Subject: Re: 2.6.14-rt1 - xruns in a certain circumstance
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark Knecht <markknecht@gmail.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051031142204.GA6136@elte.hu>
References: <5bdc1c8b0510301828p29ea517ew467a5f6503435314@mail.gmail.com>
	 <20051031142204.GA6136@elte.hu>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 11:18:47 -0500
Message-Id: <1130775527.32101.37.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-31 at 15:22 +0100, Ingo Molnar wrote:
> this could be some sort of hardware latency, as Lee suspects.
> Videocards are known to be pretty agressively holding the system bus,
> for the last few percentiles of Quake performance ... Also, mainboard
> chipsets are sometimes not that good at enforcing fairness between DMA
> agents - possibly starving the CPU itself for lengthly amounts of
> time. We have seen such incidents before, and latency tracing ought to
> be able to show this with reasonable certainty. 

Ingo,

IIRC when I had this problem with the via X driver the latency traces
actually didn't show anything useful.  The disk controller induced DMA
starvation problems did show up in the tracer.

Lee

