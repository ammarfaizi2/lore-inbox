Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265439AbTFMQb7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265435AbTFMQah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:30:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4485 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265437AbTFMQ3P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:29:15 -0400
Date: Fri, 13 Jun 2003 12:45:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Joe <joeja@mindspring.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Xeon  processors &&Hyper-Threading
In-Reply-To: <3EE9FDFA.6020803@mindspring.com>
Message-ID: <Pine.LNX.4.53.0306131241330.5894@chaos>
References: <3EE9FDFA.6020803@mindspring.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003, Joe wrote:

> Does Linux support the Xeon (p4) processor and its capabilities?
>
> The company I work for recently ported its application to Linux and one
> of our current HP clients asked this and I figure it would be just a
> recompile the kernel as a P4, but not sure if this would do it.
>
> I'm not asking if Linux can RUN the Xeon processor.
>
> I'm asking if Linux processor takes any advantage of the Hyper-Threading
> built into this processor?
>
> below is a link to more info on this.
>
> http://www.intel.com/design/xeon/prodbref/
>
> Joe
>

You recompile the kernel for SMP as well as P4. If the motherboard
hasn't disabled HT capabilities, you will take full advantage of
the processor under Linux. Whatever "full advantage" means, is
not absolute, but whatever it is, will be used to its fullest.
Basically, if the code is I/O bound, you'll not see any difference.
If the code is compute-intensive, you will.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

