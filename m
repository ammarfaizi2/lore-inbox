Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272127AbSISR6v>; Thu, 19 Sep 2002 13:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272134AbSISR6v>; Thu, 19 Sep 2002 13:58:51 -0400
Received: from [195.223.140.120] ([195.223.140.120]:6216 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272127AbSISR6u>; Thu, 19 Sep 2002 13:58:50 -0400
Date: Thu, 19 Sep 2002 20:04:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: James Cleverdon <jamesclv@us.ibm.com>,
       "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
       ak@suse.de, linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       anton.wilson@camotion.com
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
Message-ID: <20020919180409.GG1345@dualathlon.random>
References: <p73vg54tjpl.fsf@oldwotan.suse.de> <1032298092.20498.21.camel@irongate.swansea.linux.org.uk> <20020917.141806.49377410.davem@redhat.com> <200209171502.04524.jamesclv@us.ibm.com> <20020918084022.A67562@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020918084022.A67562@ucw.cz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 08:40:22AM +0200, Vojtech Pavlik wrote:
> The point here is: You don't need a synchronized bus clock. You don't
> need synchronized CPU clocks. You need a synchronized system-wide clock
> that doesn't drive any bus or CPU, just a simple counter in every CPU
> that you can read from inside the CPU. You can pull that pretty far and

Exactly.

Andrea
