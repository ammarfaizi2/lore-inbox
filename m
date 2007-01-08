Return-Path: <linux-kernel-owner+w=401wt.eu-S932640AbXAHUWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbXAHUWG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 15:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbXAHUWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 15:22:06 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:34601 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932647AbXAHUWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 15:22:05 -0500
Date: Mon, 8 Jan 2007 21:19:24 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: dean gaudet <dean@arctic.org>
cc: "H. Peter Anvin" <hpa@zytor.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] All Transmeta CPUs have constant TSCs
In-Reply-To: <Pine.LNX.4.64.0701072358010.26307@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.61.0701082118370.23737@yvahk01.tjqt.qr>
References: <200701050148.l051mHGM005275@terminus.zytor.com>
 <Pine.LNX.4.61.0701051524440.7813@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0701072358010.26307@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 8 2007 00:02, dean gaudet wrote:
>On Fri, 5 Jan 2007, Jan Engelhardt wrote:
>> On Jan 4 2007 17:48, H. Peter Anvin wrote:
>> >
>> >[i386] All Transmeta CPUs have constant TSCs
>> >All Transmeta CPUs ever produced have constant-rate TSCs.
>> 
>> A TSC is ticking according to the CPU frequency, is not it?
>
>transmeta decided years before intel and amd that a constant rate tsc 
>(unaffected by P-state) was the only sane choice.  on transmeta cpus the 
>tsc increments at the maximum cpu frequency no matter what the P-state 
>(and no matter what longrun is doing behind the kernel's back).
>
>mind you, many people thought this was a crazy choice at the time...
>
Well it defeats the purpose of TSC. I mean, they could have kept the "TSC" and
instead added a second TSC ticker, constant_tsc.


	-`J'
-- 
