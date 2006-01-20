Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161468AbWATAr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161468AbWATAr0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 19:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161428AbWATAr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 19:47:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24510 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161468AbWATArZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 19:47:25 -0500
Date: Thu, 19 Jan 2006 19:45:38 -0500
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] X86_GX_SUSPMOD must depend on PCI
Message-ID: <20060120004538.GD3798@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, cpufreq@lists.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <20060120002537.GI19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120002537.GI19398@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 01:25:37AM +0100, Adrian Bunk wrote:
 > This patch fixes the following compile error:
 > 
 > ...
 >   CC      arch/i386/kernel/cpu/cpufreq/gx-suspmod.o
 > arch/i386/kernel/cpu/cpufreq/gx-suspmod.c: In function 'gx_detect_chipset':
 > arch/i386/kernel/cpu/cpufreq/gx-suspmod.c:193: error: implicit declaration of function 'pci_match_id'
 > arch/i386/kernel/cpu/cpufreq/gx-suspmod.c:193: warning: comparison between pointer and integer
 > make[3]: *** [arch/i386/kernel/cpu/cpufreq/gx-suspmod.o] Error 1
 > 
 > <--  snip  -->
 > 
 > 
 > Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.

		Dave

