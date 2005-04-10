Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVDJWsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVDJWsn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 18:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVDJWsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 18:48:43 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29189 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261626AbVDJWsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 18:48:36 -0400
Date: Mon, 11 Apr 2005 00:48:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: 2.6.12-rc2-mm2
Message-ID: <20050410224834.GK4204@stusta.de>
References: <20050408030835.4941cd98.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408030835.4941cd98.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel-rcupdatec-make-the-exports-export_symbol_gpl.patch
add-deprecated_for_modules.patch
add-deprecated_for_modules-fix.patch
deprecate-synchronize_kernel-gpl-replacement.patch
deprecate-synchronize_kernel-gpl-replacement-fix.patch
change-synchronize_kernel-to-_rcu-and-_sched.patch


Please drop these patches.


Using these symbols in non-GPL modules is a legal problem at least in 
the USA except for IBM, and all we've heard from IBM is that they are 
not 100% sure that there is really no binary-only module by IBM that 
might use these symbols.


The risk of anyne using them only increases (no matter that it's marked 
as deprecated) as long as it's available - and nobody has until now 
claimed that he's actually using one pf them in a binary-only module.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


