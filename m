Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965219AbWEOULQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965219AbWEOULQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965215AbWEOULP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:11:15 -0400
Received: from EXCHG2003.microtech-ks.com ([24.124.14.122]:50763 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S965220AbWEOULO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:11:14 -0400
Message-ID: <4468E064.9060504@atipa.com>
Date: Mon, 15 May 2006 15:11:16 -0500
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: "Bryan O'Sullivan" <bos@pathscale.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 0 of 53] ipath driver updates for
 2.6.17-rc4
References: <patchbomb.1147477365@eng-12.pathscale.com>	<adau07ruwb5.fsf@cisco.com> <4468A59C.2030400@atipa.com> <adamzdjtgtt.fsf@cisco.com>
In-Reply-To: <adamzdjtgtt.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2006 20:02:50.0185 (UTC) FILETIME=[8B0C0B90:01C6785A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Roger> What should these patches apply against?
> 
> No idea.  Bryan said they apply against Linus's current git, but I
> didn't actually try.
> 
>  - R.
> 

I checked the rc4 -> git patches (there is only 1 ipath patch in it),
and I get a number of patch fails attempting to apply the patches,
I have the older 5/12/06 patch that was sent and I also get a number
of fails trying to apply that, though that may mean to be applied to
rc3 and not rc4, but rc4 + older patch + newer patches fails, and
rc4 + git + newer patches fails, looking through the code there are
a few things that I cannot find where the code in the context diff
came from.

I did attempt to resolve some of the funniness but there were things
that I appear to be missing (things in the context diff that I cannot
find exist in rc4 and I cannot find being added in any patch), so
I don't think I can even get everything to apply even with manual
adjusting.

                            Roger
