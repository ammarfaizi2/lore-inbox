Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270332AbTHBSt1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 14:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270338AbTHBSt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 14:49:27 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:51162 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S270332AbTHBStZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 14:49:25 -0400
Date: Sat, 2 Aug 2003 20:49:32 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Sean Estabrooks <seanlkml@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: .config in bzImage ?
Message-ID: <20030802184932.GA12057@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Sean Estabrooks <seanlkml@rogers.com>,
	linux-kernel@vger.kernel.org
References: <093901c35924$f3040ed0$7f0a0a0a@lappy7>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <093901c35924$f3040ed0$7f0a0a0a@lappy7>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 02:36:12PM -0400, Sean Estabrooks wrote:
> There was some talk of the .config file being included
> within bzImage.  Did this ever happen?  If so, how 
> does one extract the .config from the resulting image?

hmm, since ages I use for 2.4.x a small patch, which
includes the .config in the kernel image (gzipped or 
bzip2ed). this information can be retrieved from the
procfs by zcat /proc/config.gz or bzcat /proc/config.bz2
respectively ...

you can get the patch for recent 2.4.x kernels from
my pages http://www.13thfloor.at/VServer/Patches.shtml
(they are 03_kconfig* in the patchsets)

for example for 2.4.22-pre10, this would be ...
http://www.13thfloor.at/VServer/patches-2.4.22-p10c17/03_kconfig-2.4.22-pre3.patch.bz2

HTH,
Herbert

> Cheers,
> Sean
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
