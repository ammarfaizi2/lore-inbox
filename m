Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272213AbRHWEFq>; Thu, 23 Aug 2001 00:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272212AbRHWEFg>; Thu, 23 Aug 2001 00:05:36 -0400
Received: from femail27.sdc1.sfba.home.com ([24.254.60.17]:24279 "EHLO
	femail27.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272211AbRHWEFa>; Thu, 23 Aug 2001 00:05:30 -0400
From: Josh McKinney <forming@home.com>
Date: Wed, 22 Aug 2001 23:05:39 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9: GCC 3.0 problem in "acct.c"
Message-ID: <20010822230539.A5013@home.com>
Mail-Followup-To: josh, linux-kernel@vger.kernel.org
In-Reply-To: <200108222251.BAA04797@ares.sot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200108222251.BAA04797@ares.sot.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Thu, Aug 23, 2001 at 01:51:33AM +0300, Santeri Kannisto wrote:
> Except that a similar problem with capi existed allready with gcc 3.0 +
> kernels 2.4.*, and that problem was reported to gcc people multiple 
> times. But it is still broken in gcc 3.0.1:
> 
> bp2.c:414: warning: `sbp2_host_info_lock' defined but not used
> capi.c: In function `capi_ioctl':
> capi.c:1031: Unrecognizable insn:
> (insn/i 1675 3103 3100 (parallel[ capi.c:1031: Internal error: Segmentation fault
> Please submit a full bug report,
> with preprocessed source if appropriate.
> See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.
> 
> So, does anyone have any ideas? That problem is critical because
> it makes ISDN (capi 2) unusable with kernels 2.4.* + gcc 3.0.* 
> 
> All other things seem to function pretty well with 2.4.9 + 3.0.1.

I get the same sort of Unrecognizable insn: error in signal.c with my setup.
This is true today with the latest cvs gcc.

Josh
