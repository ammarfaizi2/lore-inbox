Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWEOQA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWEOQA3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 12:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWEOQA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 12:00:29 -0400
Received: from EXCHG2003.microtech-ks.com ([24.124.14.122]:4371 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1750880AbWEOQA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 12:00:28 -0400
Message-ID: <4468A59C.2030400@atipa.com>
Date: Mon, 15 May 2006 11:00:28 -0500
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: "Bryan O'Sullivan" <bos@pathscale.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 0 of 53] ipath driver updates for
 2.6.17-rc4
References: <patchbomb.1147477365@eng-12.pathscale.com> <adau07ruwb5.fsf@cisco.com>
In-Reply-To: <adau07ruwb5.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2006 15:52:03.0326 (UTC) FILETIME=[826B91E0:01C67837]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> Umm... dumping a 53 patch series into the kernel at this stage in the
> release cycle isn't going to work.  You need to sort out the patches
> that need to go into 2.6.17 from patches that can wait.  For example,
> a 1500+ line patch to factor out common code is clearly not
> appropriate now.  Pretty much the only patches that should be going in
> now are changes that fix crashes or other serious bugs.
> 
> (You can send both sets of patches at the same time -- just let me
> which ones are for 2.6.17 and which ones can be queued for 2.6.18)
> 
> I have some more specific comments in reply to individual patches,
> although I didn't try to review all 53.
> 
>  - R.


Roland,

What should these patches apply against?

I have tried rc4 and a number of them fail, and I have also
tried one of your gits (though maybe not the right one), and
at least some of the the same patches seem to fail to apply
there.

If I can get an idea what they should apply to I will apply them
against that and see how things look.

I have at least one of the nasty bugs that I know about.

                             Roger
