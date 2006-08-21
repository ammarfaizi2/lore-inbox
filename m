Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWHUB7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWHUB7a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 21:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWHUB7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 21:59:30 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:65041 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750766AbWHUB7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 21:59:30 -0400
Date: Mon, 21 Aug 2006 03:59:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: 2.6.18-rc4-mm2: tickadj removal breaks 6 architectures
Message-ID: <20060821015929.GF11651@stusta.de>
References: <20060819220008.843d2f64.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819220008.843d2f64.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ntp-add-time_adjust-to-tick-length.patch removes the tickadj variable 
that is according to grep still used on six architectures (I've seen 
the compile error on m68k and sparc, haven't checked the other four).

Roman, you should also try your patches on exotic architectures
like m68k. ;-)

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

