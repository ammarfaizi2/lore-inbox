Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWCVJZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWCVJZk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWCVJZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:25:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50568 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751155AbWCVJZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:25:39 -0500
Date: Wed, 22 Mar 2006 01:22:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexander Clouter <alex@digriz.org.uk>
Cc: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org,
       venkatesh.pallipadi@intel.com, linux@dominikbrodowski.de
Subject: Re: [patch 1/4] cpufreq_conservative: update and align of codebase
Message-Id: <20060322012210.1c0fb11f.akpm@osdl.org>
In-Reply-To: <20060322085807.GA10689@inskipp.digriz.org.uk>
References: <20060322085807.GA10689@inskipp.digriz.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Clouter <alex@digriz.org.uk> wrote:
>
> *NEW* patches, for kernel 2.6.16
> 
>  Something I had been meaning to do for a while.  The codebases between
>  ondemand and conservative have strayed and as Venkatesh has far more Clue(tm)
>  than I am going to adjust my code to look more like his :)
> 
>  Another reason to do this is ages ago, knowingly, I did a piss poor attempt
>  at making conservative less responsive by knocking up
>  DEF_SAMPLING_RATE_LATENCY_MULTIPLIER by two orders of magnitude.  I did fix
>  this ages ago but in my dis-organisation I must have toasted the diff and
>  left it the way it was.  About two weeks ago a user contacted me saying he
>  was having problems with the conservative governor with his AMD Athlon XP-M
>  2800+ as /sys/devices/system/cpu/cpu0/cpufreq/conservative showed
>    sampling_rate_min   9950000
>    sampling_rate_max   1360065408
> 
>  Nine seconds to decide about changing the frequency....not too responsive :)

umm, that's not really a changelog.  Please, see
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt.  Section 2a is
relevant too..

Thanks.
