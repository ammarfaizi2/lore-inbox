Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267491AbUHPJnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267491AbUHPJnl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 05:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUHPJnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 05:43:41 -0400
Received: from shockwave.systems.pipex.net ([62.241.160.9]:54957 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S267491AbUHPJnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 05:43:39 -0400
Message-ID: <412081C6.20601@tungstengraphics.com>
Date: Mon, 16 Aug 2004 10:43:34 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
Cc: Dave Airlie <airlied@linux.ie>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: DRM and 2.4 ...
References: <Pine.LNX.4.58.0408160652350.9944@skynet> <1092640312.2791.6.camel@laptop.fenrus.com>
In-Reply-To: <1092640312.2791.6.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, 2004-08-16 at 07:56, Dave Airlie wrote:
> 
>>At the moment we are adding a lot of 2.6 stuff to the DRM under
>>development in the DRM CVS tree and what will be merged into the -mm and
>>Linus trees eventually, this has meant ifdefing stuff out so 2.4 will
>>still work,
> 
> 
> which is uglyfying the code significantly if done wrong
> 
> 
>>So the question is do we want to a final stable DRM for 2.4 in the next
>>2.4 release? and after that point I can tag the 2.4 release in the DRM CVS
>>tree (and maybe branch it ...),
> 
> 
> I would strongly urge you to no longer update DRM in 2.4 in significant
> ways. 2.4 is the release for doing strict maintenance; people who want
> to run newer X will generally run 2.6 kernels as well anyway.

I'm not at all convinced we (ie the DRI project) can abandon 2.4 support.  In 
fact we made this mistake with the 2.2/2.4 transition - we didn't support 2.2 
at all, only 2.4 and for a long time this was a big inconvenience to users.

We may not be feeding our changes into the 2.4 kernel (or maybe we are), but I 
definitely view 2.4 support as important for probably 1 to 2 years to come.

If we can manage to support FreeBSD and Linux from one codebase, surely 
supporting 2.4 and 2.6 isn't too difficult?

Keith

