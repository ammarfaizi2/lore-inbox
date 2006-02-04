Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWBDTXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWBDTXF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 14:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWBDTXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 14:23:04 -0500
Received: from dvhart.com ([64.146.134.43]:34454 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932477AbWBDTXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 14:23:03 -0500
Message-ID: <43E4FF13.2050206@mbligh.org>
Date: Sat, 04 Feb 2006 11:22:59 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Koschewski <marc@osknowledge.org>
Cc: dtor_core@ameritech.net, rlrevell@joe-job.com, 76306.1226@compuserve.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: Wanted: hotfixes for -mm kernels
References: <200602021502_MC3-1-B772-547@compuserve.com> <1138913633.15691.109.camel@mindpipe> <d120d5000602021345i255bb69eydb67bc1b0a448f8d@mail.gmail.com> <20060203100703.GA5691@stiffy.osknowledge.org> <20060204083752.a5c5b058.mbligh@mbligh.org> <20060204185738.GA5689@stiffy.osknowledge.org>
In-Reply-To: <20060204185738.GA5689@stiffy.osknowledge.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We talked about hotfixes for -mm. So why not check these into the -mm-git tree
> then? This would make sense and would conform fully to my understanding of what
> the -mm-git tree should be. I don't want to select 23 patches from LKML to make
> the tree compile or work. I want to checkout. Why make it easy when you may get
> it difficult.
> 
> Besides testing the stuff we would get more far by being able to test stuff faster
> (because a patch is applied to -mm and we do a checkout) instead of waiting a
> week for this mega-patch to be applied.
> 
> What sense does an -mm tree make when there are people that cannot test it because of
> known bugs that lead to the -mm tree not being bootable or - even worse - destroying
> the system?
> 
> git is you friend. Not only for Linus' tree, but as well for Andrew's tree.
> It would just make debugging and testing -mm more convenient and less time
> consuming for the testers. Instead of 1000 people seeking patches Andrew would
> just check in and we all could pull it.
> 
> If you agree with me or not - that's what I think.

SCMs don't fix anything. The real work is in selecting patches and 
merging them. Frankly,  I test a lot of stuff myself, and the tarballs 
are  a damned sight easier to work with, and have a simple chronological 
timeline to work from.

Yes, of course you don't want to pull 23 separate patches from a mailing 
list. But quilt+tarballs is a crapload simpler than git / bk / cvs / 
subversion, and works just as well, if not better. It just needs a 
script to roll up patches into a consolidated one, and it's not like 
Andrew doesn't have that already.

M.
