Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTIJJsY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 05:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbTIJJsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 05:48:23 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:7808 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261196AbTIJJsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 05:48:22 -0400
Date: Wed, 10 Sep 2003 11:01:36 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309101001.h8AA1amm000407@81-2-122-30.bradfords.org.uk>
To: davidsen@tmr.com
Subject: Re: Scaling noise
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> | Once the option of running a firewall, a hot spare firewall, a
> | customer webserver, a hot spare customer webserver, mail server,
> | backup mail server, and a few virtual machines for customers, all on a
> | 1U box, why are you going to want to pay for seven or more Us in a
> | datacentre, plus extra network hardware?
>
> If you plan to run anything else on your firewall, and use the same
> machine as a hot spare for itself, I don't want you as my ISP.
> Reliability is expensive, and what you describe is known as a single
> point of failure.

Of course, you would be right if we were talking about current
microcomputer architectures.  I was talking about the possibility of
current mainframe technologies being implemented in future
microcomputer architectures.

Today, it is perfectly acceptable, normal, and commonplace to run hot
spares of various images on a single Z/Series box.  Infact, the
ability to do that is often a large factor in budgeting for the
initial investment.

The hardware is fault tollerant by design.  Only extreme events like a
fire or flood at the datacentre are likely to cause downtime of the
whole machine.  I don't consider that any less secure than a rack of
small servers.

Different images running in their own LPARs, or under Z/Vm are
separated from each other.  Assessments of their isolation have been
done, and ratings are available.

You absolutely _can_ use the same physical hardware to run a hot
spare, and protect yourself against software failiures.  A process can
monitor the virtual machine, and switch to the hot spare if it fails.

Add to that the fact that physical LAN cabling is reduced.  The amount
of network hardware is also reduced.  That adds to reliability.

John.
