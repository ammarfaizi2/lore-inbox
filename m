Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbUKMMRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbUKMMRJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 07:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbUKMMRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 07:17:09 -0500
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:63504 "EHLO
	smtp-vbr14.xs4all.nl") by vger.kernel.org with ESMTP
	id S261823AbUKMMRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 07:17:06 -0500
Date: Sat, 13 Nov 2004 13:16:28 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: md linear personality oops on boot with 2.6.10-rc1-mm4 and 2.6.10-rc1-mm5
Message-ID: <20041113121628.GA3045@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20041112143012.GA3676@middle.of.nowhere> <16789.46845.6950.773945@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16789.46845.6950.773945@cse.unsw.edu.au>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Brown <neilb@cse.unsw.edu.au>
Date: Sat, Nov 13, 2004 at 06:25:49PM +1100
> On Friday November 12, thunder7@xs4all.nl wrote:
> > 
> > In 2.6.9-mm1, this works.
> > In 2.6.10-rc1-mm4 and 2.6.10-rc1-mm5, I get an oops during boot:
> > 
> > linear_run+0x20b
> > 
> 
> Thanks.  Looks like an unsigned variable going negative:-(
> I made the mistake of only testing it with a linear array with all
> components the same size.
> 
> Please verify that this patch fixes it.
> 
Excellent, this makes 2.6.10-rc1-mm5 boot without any problems.

Kind regards,
Jurriaan
-- 
53 reasons why Janeway is better than Picard:
(47) Kes. Troi. No contest.
Debian (Unstable) GNU/Linux 2.6.9-mm1 2x6078 bogomips load 0.00
