Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288821AbSAIFbE>; Wed, 9 Jan 2002 00:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288823AbSAIFax>; Wed, 9 Jan 2002 00:30:53 -0500
Received: from [202.135.142.194] ([202.135.142.194]:47884 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S288821AbSAIFai>; Wed, 9 Jan 2002 00:30:38 -0500
Date: Wed, 9 Jan 2002 14:28:37 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
Message-Id: <20020109142837.3ee52fe0.rusty@rustcorp.com.au>
In-Reply-To: <a1gcme$18t$1@cesium.transmeta.com>
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com>
	<20020108201451.088f7f99.rusty@rustcorp.com.au>
	<a1f9j9$5i9$1@cesium.transmeta.com>
	<20020109120108.39bcf7ad.rusty@rustcorp.com.au>
	<a1gcme$18t$1@cesium.transmeta.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Jan 2002 19:16:30 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:
> So you chown an entry, then a module is unloaded and reloaded, now
> what happens?

Sorry, was responding to the second sentence, not the first:

> However, procfs has no permission control
> system set up, unlike /dev.  This is inherent; adjusting sysctls is a
> root-only function and cannot be made otherwise.

In practice, my /proc/sys perms are four bits: ALL READ, ALL WRITE, ROOT READ, ROOT WRITE.

Hope that helps,
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
