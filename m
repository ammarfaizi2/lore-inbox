Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264545AbTLMKfc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 05:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbTLMKfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 05:35:32 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:5248 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264545AbTLMKf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 05:35:28 -0500
Date: Sat, 13 Dec 2003 10:40:44 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200312131040.hBDAeisM000455@81-2-122-30.bradfords.org.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0312121435570.1356@chaos>
References: <16345.51504.583427.499297@l.a>
 <yw1xd6auyvac.fsf@kth.se>
 <Pine.LNX.4.53.0312121000150.10423@chaos>
 <200312121928.hBCJSLBs000384@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.53.0312121435570.1356@chaos>
Subject: Re: PROBLEM: floppy motor spins when floppy module not installed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from "Richard B. Johnson" <root@chaos.analogic.com>:

> Yes, and I recall we agreed to disagree where the FDC stop must
> be put, but we both agreed that it must be stopped. I still contend
> that since the Linux startup code takes control away from the BIOS,
> it's that codes responsibility to turn OFF things that the BIOS
> might have left ON.

Well, on a practical level, yes, I agree with you, it is the easiest
way to solve the problem.

On a technical level, I still think that the BIOS configuration is
broken if it leaves the floppy motor on, on a system running a kernel
without the floppy code compiled in.

John.
