Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbTEEM2O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 08:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbTEEM2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 08:28:14 -0400
Received: from ns.suse.de ([213.95.15.193]:64009 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262162AbTEEM2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 08:28:13 -0400
Date: Mon, 5 May 2003 14:40:42 +0200
From: Dave Jones <davej@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [CFT] re-slabify i386 pgd's and pmd's
Message-ID: <20030505144042.B19403@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030505105213.GO8931@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030505105213.GO8931@holomorphy.com>; from wli@holomorphy.com on Mon, May 05, 2003 at 03:52:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 03:52:13AM -0700, William Lee Irwin III wrote:

 > I would very much appreciate outside testers. Even though I've been
 > able to verify this boots and runs properly and survives several cycles
 > of restarting X on my non-PAE Thinkpad T21, that environment has never
 > been able to reproduce the bug. Those with the proper graphics hardware
 > to prod the affected codepaths into action are the ones best suited to
 > verify proper functionality.

For reference, Linus was seeing problems on i830 chipset with onboard
graphics. Testers from all i8xx would be equally useful, as there are
a lot of shared paths in agpgart for these chipsets.
The onboard graphics part also seemed to be a factor. People using
proper agp-slot graphics cards never saw this issue.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
