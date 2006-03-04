Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWCDMsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWCDMsz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 07:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWCDMsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 07:48:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:50412 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751489AbWCDMsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 07:48:54 -0500
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64 aliasing problem)
Date: Sat, 4 Mar 2006 06:21:00 +0100
User-Agent: KMail/1.9.1
Cc: anemo@mba.ocn.ne.jp, clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, johnstul@us.ibm.com, rth@twiddle.net
References: <20060303.114406.64806237.nemoto@toshiba-tops.co.jp> <20060304112010.GA94875@muc.de> <20060304034050.40f29251.akpm@osdl.org>
In-Reply-To: <20060304034050.40f29251.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603040621.00782.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 March 2006 12:40, Andrew Morton wrote:

> Making `jiffies_64' a #define is less risky, but that doesn't work for
> 32-bit.

I meant the define on 64bit only. You're right on 32bit it would be somewhat messy.
But then we have to solve the problem on 32bit anyways, so it wasn't that hot
an idea.

-Andi
