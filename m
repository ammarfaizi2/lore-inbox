Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293055AbSB1AAc>; Wed, 27 Feb 2002 19:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293083AbSB1AAC>; Wed, 27 Feb 2002 19:00:02 -0500
Received: from zero.tech9.net ([209.61.188.187]:54534 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293082AbSB0X7e>;
	Wed, 27 Feb 2002 18:59:34 -0500
Subject: Re: [PATCH] 2.5: proc interface for setting task affinity
From: Robert Love <rml@tech9.net>
To: peter <peter.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1014853926.21516.20.camel@twins.localnet>
In-Reply-To: <1014852882.1109.218.camel@phantasy> 
	<1014853926.21516.20.camel@twins.localnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 27 Feb 2002 18:59:37 -0500
Message-Id: <1014854378.1109.238.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-02-27 at 18:52, peter wrote:

> This is great news,. could you please backport this to 2.4.x + O(1).
> That would mean that I can finaly use the new scheduler.
> I need to run X on a single CPU because the MGA-G400 driver has some
> SMP difficulties.

See if this patch applies on 2.4, it probably does.  If not I'll look
into the rejects when I get a chance ...

Note also that much of the thanks for these interfaces should go to
Ingo, since he got set_cpus_allowed working with p != current.

btw: I have an MGA-G550 (uses the same mga driver as you) and have no
problems with X on an SMP machine ...

	Robert Love

