Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSKTSrv>; Wed, 20 Nov 2002 13:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbSKTSrv>; Wed, 20 Nov 2002 13:47:51 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:32648 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262067AbSKTSrq>;
	Wed, 20 Nov 2002 13:47:46 -0500
Date: Wed, 20 Nov 2002 18:53:11 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [CFT] Athlon testers needed.
Message-ID: <20021120185311.GB10698@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In some obscure documentation, I found out that recent Athlons
(model 8 stepping 1 and greater) behave better with certain MSRs
programmed slightly differently to those of earlier models.
It's likely a lot of BIOSen out there don't get this right
(Especially in the BIOS older than CPU case).

x86info[1] will be able to dump these registers (run as root
and use -m option), and mail me the results so I can confirm
my suspicions.  I've a patch pending, but I'd rather get some
test data before unleashing it on unsuspecting victims.

I'm particularly interested in hearing from folks who have
been experiencing problems with model 8 and above Athlons,
earlier models are less interesting for the moment.

		Dave

[1] http://www.codemonkey.org.uk/x86info/x86info-1.11.tar.gz


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
