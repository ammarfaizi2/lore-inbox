Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289061AbSAGApm>; Sun, 6 Jan 2002 19:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289062AbSAGApc>; Sun, 6 Jan 2002 19:45:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37137 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289061AbSAGApW>; Sun, 6 Jan 2002 19:45:22 -0500
Message-ID: <3C38EF83.5000003@zytor.com>
Date: Sun, 06 Jan 2002 16:44:51 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Matt Dainty <matt@bodgit-n-scarper.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com> <200201061934.g06JYnZ15633@vindaloo.ras.ucalgary.ca> <3C38BC6B.7090301@zytor.com> <200201062108.g06L8lM17189@vindaloo.ras.ucalgary.ca> <3C38BD32.6000900@zytor.com> <20020106213619.C7654@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> On Sun, Jan 06, 2002 at 01:10:10PM -0800, H. Peter Anvin wrote:
> 
>>The existence of a CPU creates /dev/cpu/# and registering a node 
>>replicates across the /dev/cpu directories.
>>
> 
> And, thus, we decend into more /proc crappyness.
> 
> After *lots* of discussion and months of waiting, it was decided between
> Alan, David Jones, Jeff Garzik, and other affected parties that
> /proc/sys/cpu/#/whatever would be a reasonable.  It has even appeared on
> lkml a couple of times in the past.
> 


Ummm... this isn't about /proc.

	-hpa


