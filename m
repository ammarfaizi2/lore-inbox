Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291168AbSBLUVp>; Tue, 12 Feb 2002 15:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291171AbSBLUVg>; Tue, 12 Feb 2002 15:21:36 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:28680
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S291168AbSBLUVU>; Tue, 12 Feb 2002 15:21:20 -0500
Subject: Re: 2.4.18-pre9-xfs-shawn4  -  kmem_cache_alloc oops
From: Shawn Starr <spstarr@sh0n.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux <linux-kernel@vger.kernel.org>
In-Reply-To: <3C6977A3.1F509184@zip.com.au>
In-Reply-To: <20020212141007.B223@dagb>, <20020212141007.B223@dagb>
	<1013523257.262.3.camel@unaropia>  <3C6977A3.1F509184@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 12 Feb 2002 15:23:38 -0500
Message-Id: <1013545446.9761.1.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll be merging to -pre9-ac2 today.

On Tue, 2002-02-12 at 15:14, Andrew Morton wrote:
> Shawn Starr wrote:
> > 
> > Interesting, I have CONFIG_PNPBIOS on.
> > What other filesystems do you have or is it just XFS only?
> > 
> 
> Known bug in -ac kernels.  It's due to initialisation-order
> disagreement between Alan and I.  It looks like Alan has fixed
> it in 2.4.18-pre9-ac2.  For earlier -ac's, disable the pnpbios
> driver in config.
> 
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


