Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316587AbSGYRvl>; Thu, 25 Jul 2002 13:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSGYRvl>; Thu, 25 Jul 2002 13:51:41 -0400
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:2052
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S316587AbSGYRvk> convert rfc822-to-8bit; Thu, 25 Jul 2002 13:51:40 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: Dave Jones <davej@suse.de>
Subject: Re: MTRR Problems - 2.4.19-rc3
Date: Thu, 25 Jul 2002 13:55:59 -0400
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
References: <200207250303.20809.spstarr@sh0n.net> <200207251341.24933.spstarr@sh0n.net> <20020725195000.A8672@suse.de>
In-Reply-To: <20020725195000.A8672@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207251355.59880.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there a fix to this?

Shawn.

On July 25, 2002 01:50 pm, Dave Jones wrote:

> On Thu, Jul 25, 2002 at 01:41:24PM -0400, Shawn Starr wrote:
>  > > > mtrr: no MTRR for e0000000,4000000 found
>  >
>  > Fair enough, but that doesn't explain the broken MTRR :)
>
> Something in userspace tried to delete an MTRR that didn't exist.
> The only time I've seen this happen personally has been with
> a dual-head card for which the BIOS set up one MTRR to cover
> the video ram used by both heads, and then iirc X did something
> silly and tried to remove separate MTRRs for each head on exit.
>
>         Dave

