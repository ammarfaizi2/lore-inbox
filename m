Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSAIDDW>; Tue, 8 Jan 2002 22:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288749AbSAIDDM>; Tue, 8 Jan 2002 22:03:12 -0500
Received: from [202.135.142.196] ([202.135.142.196]:60166 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S288748AbSAIDDI>; Tue, 8 Jan 2002 22:03:08 -0500
Date: Wed, 9 Jan 2002 12:01:08 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
Message-Id: <20020109120108.39bcf7ad.rusty@rustcorp.com.au>
In-Reply-To: <a1f9j9$5i9$1@cesium.transmeta.com>
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com>
	<200201070140.g071ewk21192@vindaloo.ras.ucalgary.ca>
	<20020108111302.A14860@mould.bodgit-n-scarper.com>
	<20020108201451.088f7f99.rusty@rustcorp.com.au>
	<a1f9j9$5i9$1@cesium.transmeta.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Jan 2002 09:17:29 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:
> /proc/sys is pretty cool.  However, procfs has no permission control
> system set up, unlike /dev.  This is inherent; adjusting sysctls is a
> root-only function and cannot be made otherwise.

Incorrect.  See my new /proc/sys implementation patch.  It's hidden in the
flames somewhere...

Cheers,
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
