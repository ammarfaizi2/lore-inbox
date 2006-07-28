Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030179AbWG1TQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030179AbWG1TQV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 15:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWG1TQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 15:16:21 -0400
Received: from wasp.net.au ([203.190.192.17]:8883 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1030179AbWG1TQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 15:16:21 -0400
Message-ID: <44CA627A.7060509@wasp.net.au>
Date: Fri, 28 Jul 2006 23:16:10 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Jason Lunz <lunz@falooley.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] amd74xx: implement suspend-to-ram
References: <200607281646.31207.rjw@sisk.pl> <1154105517.13509.153.camel@localhost.localdomain> <20060728171357.GB17549@knob.reflex>
In-Reply-To: <20060728171357.GB17549@knob.reflex>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Lunz wrote:

> 
> I poked around in ide-io.c a little while writing the patch, but my
> assumption so far has been that the core ide suspend is OK wrt s2ram,
> since I never hear IDE cited as the reason for s2ram failure. Usually
> it's ACPI or video problems.

Actually I had exactly your issue on an ICH6 and ended up working around it by moving to Alan's 
latest libata code.

0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller 
(rev 03)

If you were to patch up IDE I'd be happy to run up a couple of test kernels and test it out on an 
Intel chipset also.

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
