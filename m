Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSHBPqX>; Fri, 2 Aug 2002 11:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315456AbSHBPqX>; Fri, 2 Aug 2002 11:46:23 -0400
Received: from mta02bw.bigpond.com ([139.134.6.34]:53720 "EHLO
	mta02bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S315454AbSHBPqW>; Fri, 2 Aug 2002 11:46:22 -0400
Message-ID: <3D4AAB32.8050608@snapgear.com>
Date: Sat, 03 Aug 2002 01:54:26 +1000
From: gerg <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.5.30uc0 MMU-less patches
References: <3D4A27FE.8030801@snapgear.com> <20020802141652.E25761@suse.de> <3D4AA573.3000705@snapgear.com> <20020802173449.N25761@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Dave Jones wrote:
> On Sat, Aug 03, 2002 at 01:29:55AM +1000, gerg wrote:
>  > Yep, there sure is some crap in there :-)
>  > Obviously left over from the original copy out
>  > from arch/i386/config.in.
>  > 
>  > I have cleaned all that silly stuff out for the
>  > next patch.
> 
> With the silly nits like that aside, it leaves just the
> more serious 'issues' such as those brought up by Willy
> earlier.
> 
> The whole idea of a seperate mmnommu (or was it nommumm/ ?)
> directory seemed a bit odd-looking too. (Asides from the
> horrible name)

It surely is a horrible name :-)


> I didn't check the code in detail, but
> is there really that little that can be shared between
> the regular mm/ ?

No, there is actually a lot in common. Probably something
like 70%. This is really a question of organization.

I would much prefer to see the non-mmu support in with mm.
But it would mean a few #ifdef's in there to allow for
the differences.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.snapgear.com

