Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbWFISEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWFISEG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbWFISEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:04:05 -0400
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:596 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030278AbWFISED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:04:03 -0400
Message-ID: <4489B83E.9090104@sbcglobal.net>
Date: Fri, 09 Jun 2006 13:04:46 -0500
From: Matthew Frost <artusemrys@sbcglobal.net>
Reply-To: artusemrys@sbcglobal.net
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>	<448997FA.50109@garzik.org> <m3irnacohp.fsf@bzzz.home.net>	<44899A1C.7000207@garzik.org> <m3ac8mcnye.fsf@bzzz.home.net>
In-Reply-To: <m3ac8mcnye.fsf@bzzz.home.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
>>>>>> Jeff Garzik (JG) writes:
> 
>  JG> Think about how this will be deployed in production, long term.
> 
>  JG> If extents are not made default at some point, then no one will use
>  JG> the feature, and it should not be merged.
> 
> sorry, I disagree. for example, NUMA isn't default and shouldn't be.
> but we have it in the tree and any one may choose to use it.

NUMA is designed to cope with a hardware feature, which not everybody 
has.  Filesystem upgrades are not qualitatively similar; it does not 
depend on one's hardware design as to whether one uses ext3, let alone 
extents.  Your logic is faulty.

  the same
> with extents. let's have it in. but let's make clear it's experimental,
> it makes sense for large files only, it isn't backward compatible and
> so on.
> 
> thanks, Alex
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

