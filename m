Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289062AbSAGBd0>; Sun, 6 Jan 2002 20:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289063AbSAGBdQ>; Sun, 6 Jan 2002 20:33:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39186 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289062AbSAGBdC>; Sun, 6 Jan 2002 20:33:02 -0500
Message-ID: <3C38FAB0.4000503@zytor.com>
Date: Sun, 06 Jan 2002 17:32:32 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Matt Dainty <matt@bodgit-n-scarper.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com>	<200201061934.g06JYnZ15633@vindaloo.ras.ucalgary.ca>	<3C38BC6B.7090301@zytor.com>	<200201062108.g06L8lM17189@vindaloo.ras.ucalgary.ca>	<3C38BD32.6000900@zytor.com> <200201070131.g071VrM20956@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:

> 
> So you mean something like this:
> 
> void devfs_per_cpu_register (const char *leafname, unsigned int flags,
> 			     unsigned int major, unsigned int minor_start,
> 			     umode_t mode, void *ops);
> 
> void devfs_per_cpu_unregister (const char *leafname);
> 
> with code in the per-cpu boot code to create the /dev/cpu/%d
> directories.
> 


Yes, that sounds like a good way to do it.

	-hpa


