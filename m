Return-Path: <linux-kernel-owner+w=401wt.eu-S1751845AbXAQWRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbXAQWRZ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 17:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbXAQWRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 17:17:24 -0500
Received: from smtp.osdl.org ([65.172.181.24]:49232 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932311AbXAQWRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 17:17:23 -0500
Date: Wed, 17 Jan 2007 14:17:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: christopher.leech@intel.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc4-mm1 - cvs merge whoops in git-ioat.patch?
Message-Id: <20070117141718.824df05b.akpm@osdl.org>
In-Reply-To: <200701172109.l0HL9fdw019715@turing-police.cc.vt.edu>
References: <200701172109.l0HL9fdw019715@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 17 Jan 2007 16:09:41 -0500 Valdis.Kletnieks@vt.edu wrote:
> commit d8238afa7eedc047b57da7ec98e98fb051fc4e85
> Author: Chris Leech <christopher.leech@intel.com>
> Date:   Fri Nov 17 11:37:29 2006 -0800
> 
>     I/OAT: Add documentation for the tcp_dma_copybreak sysctl
> 
>     Signed-off-by: Chris Leech <christopher.leech@intel.com>
> 
> looks fishy, like a cvs update went bad:
> 
> diff -puN Documentation/networking/ip-sysctl.txt~git-ioat Documentation/networking/ip-sysctl.txt
> --- a/Documentation/networking/ip-sysctl.txt~git-ioat
> +++ a/Documentation/networking/ip-sysctl.txt
> @@ -387,6 +387,22 @@ tcp_workaround_signed_windows - BOOLEAN
>         not receive a window scaling option from them.
>         Default: 0
> 
> +<<<<<<< HEAD/Documentation/networking/ip-sysctl.txt
> +=======
> +tcp_slow_start_after_idle - BOOLEAN
> +       If set, provide RFC2861 behavior and time out the congestion
> 

Yeah, that's a git merge error.  I fix lots of them but didn't bother with
this one because it's just a .txt file.  It'll go away when Chris gets
around to cleaning up that tree.
