Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbTGBIvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 04:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbTGBIvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 04:51:20 -0400
Received: from mta07ps.bigpond.com ([144.135.25.132]:26601 "EHLO
	mta07ps.bigpond.com") by vger.kernel.org with ESMTP id S264860AbTGBIuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 04:50:17 -0400
Date: Wed, 02 Jul 2003 19:03:46 +1000
From: Srihari Vijayaraghavan <harisri@bigpond.com>
Subject: Re: PROBLEM: USB Serial oops in 2.4.22-pre2
In-reply-to: <20030702033417.GB3272@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <200307021903.46535.harisri@bigpond.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5
References: <200307021222.09764.harisri@bigpond.com>
 <20030702033417.GB3272@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

It doesn't happen with 2.4.21.

I've found an easy way to trigger this bug. I've used KPPP-Modem-Query Modem 
command, when it's querying the device I just unplug the device, then the 
kernel oopses.

I couldn't test with 2.5 yet, I've come to realise the touch-pad on my laptop 
doesn't work with 2.5.73, I'll let you know the result once I get it to work 
under 2.5.latest.

Thanks. 
-- 
Hari

