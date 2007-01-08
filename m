Return-Path: <linux-kernel-owner+w=401wt.eu-S1161181AbXAHIC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161181AbXAHIC1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161182AbXAHIC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:02:27 -0500
Received: from twinlark.arctic.org ([207.29.250.54]:41933 "EHLO
	twinlark.arctic.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161181AbXAHIC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:02:27 -0500
Date: Mon, 8 Jan 2007 00:02:26 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: "H. Peter Anvin" <hpa@zytor.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] All Transmeta CPUs have constant TSCs
In-Reply-To: <Pine.LNX.4.61.0701051524440.7813@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0701072358010.26307@twinlark.arctic.org>
References: <200701050148.l051mHGM005275@terminus.zytor.com>
 <Pine.LNX.4.61.0701051524440.7813@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007, Jan Engelhardt wrote:

> 
> On Jan 4 2007 17:48, H. Peter Anvin wrote:
> >
> >[i386] All Transmeta CPUs have constant TSCs
> >All Transmeta CPUs ever produced have constant-rate TSCs.
> 
> A TSC is ticking according to the CPU frequency, is not it?

transmeta decided years before intel and amd that a constant rate tsc 
(unaffected by P-state) was the only sane choice.  on transmeta cpus the 
tsc increments at the maximum cpu frequency no matter what the P-state 
(and no matter what longrun is doing behind the kernel's back).

mind you, many people thought this was a crazy choice at the time...

-dean
