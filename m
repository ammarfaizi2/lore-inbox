Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275308AbTHSCoG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 22:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275310AbTHSCoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 22:44:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65291 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S275308AbTHSCoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 22:44:04 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
Date: 18 Aug 2003 19:43:23 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bhs2sb$3fd$1@cesium.transmeta.com>
References: <3F3EB8FA.1080605@sktc.net> <MDEHLPKNGKAHNMBLJOLKEEBAFDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <MDEHLPKNGKAHNMBLJOLKEEBAFDAA.davids@webmaster.com>
By author:    "David Schwartz" <davids@webmaster.com>
In newsgroup: linux.dev.kernel
> 
> 	There is no mechanism that is guaranteed to terminate a process other than
> sending yourself an exception that is not caught. So in cases where you must
> guarantee that your process terminates, it is perfectly reasonable to send
> yourself a SIGILL.
> 

exit(2)?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
