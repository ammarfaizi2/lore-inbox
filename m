Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbSKTNJs>; Wed, 20 Nov 2002 08:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266078AbSKTNJs>; Wed, 20 Nov 2002 08:09:48 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:42373 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266069AbSKTNJo>;
	Wed, 20 Nov 2002 08:09:44 -0500
Date: Wed, 20 Nov 2002 13:15:02 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Mathias Kretschmer <mathias@lemur.sytes.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Recognize Tualatin cache size in 2.4.x
Message-ID: <20021120131502.GA1768@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Mathias Kretschmer <mathias@lemur.sytes.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3DDAE846.6080503@lemur.sytes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDAE846.6080503@lemur.sytes.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 08:41:26PM -0500, Mathias Kretschmer wrote:
 > I just patched my 2.4.20rc2 kernel. Now, it reports
 > 512K cache for my 2 Tualatin 1.26 GHz CPUs.
 > 
 > 'time make -j4 bzImage' went down from 3:30 to 3:04.
 > Not too bad.

That is quite an impressive gain.  The patch I sent Marcelo which
also fixes up a problem with some tualatins and adds P4 trace cache
support is at..

ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.4/2.4.20/descriptors.diff

As you have tualatins can you try with the above patch and make sure
theres no regressions there ?

		Dave
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
