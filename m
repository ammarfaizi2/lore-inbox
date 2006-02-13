Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWBMGIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWBMGIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 01:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWBMGIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 01:08:55 -0500
Received: from fsmlabs.com ([168.103.115.128]:42447 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1750789AbWBMGIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 01:08:55 -0500
X-ASG-Debug-ID: 1139810932-16286-22-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Sun, 12 Feb 2006 22:13:27 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Marko <letterdrop@gmx.de>
cc: linux-kernel@vger.kernel.org
X-ASG-Orig-Subj: Re: How getting a pointer on the per-cpu struct tss_struct??
Subject: Re: How getting a pointer on the per-cpu struct tss_struct??
In-Reply-To: <20060213011412.0779d337.letterdrop@gmx.de>
Message-ID: <Pine.LNX.4.64.0602121712450.10777@montezuma.fsmlabs.com>
References: <20060213002706.50e5289c.letterdrop@gmx.de>
 <Pine.LNX.4.64.0602121552520.10777@montezuma.fsmlabs.com>
 <20060213011412.0779d337.letterdrop@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.8651
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, Marko wrote:

> Thanks for answering.
> 
> So when I don't want to change the kernel, the only way to get
> a pointer on the IO Permission Bitmap is using the TSS entry in
> the GDT??
> 
> Or is there another way to access the current structure tss_struct??

How about saving the GDT and then fetching the TSS from there?
