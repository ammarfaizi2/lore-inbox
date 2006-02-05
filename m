Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946174AbWBEHHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946174AbWBEHHO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 02:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946175AbWBEHHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 02:07:14 -0500
Received: from zlynx.org ([199.45.143.209]:8452 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S1946174AbWBEHHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 02:07:12 -0500
Message-ID: <43E5A408.90901@acm.org>
Date: Sun, 05 Feb 2006 00:06:48 -0700
From: Zan Lynx <zlynx@acm.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Luke-Jr <luke@dashjr.org>
CC: Christopher Friesen <cfriesen@nortel.com>,
       Lee Revell <rlrevell@joe-job.com>,
       Ian Kester-Haney <ikesterhaney@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <Pine.LNX.4.40.0601280826160.29965-100000@jehova.dsm.dk> <1138906199.15691.54.camel@mindpipe> <43E25976.6090109@nortel.com> <200602050358.49454.luke@dashjr.org>
In-Reply-To: <200602050358.49454.luke@dashjr.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke-Jr wrote:
> On Thursday 02 February 2006 19:11, Christopher Friesen wrote:
>   
>>  ship the binary blob as well as code that interfaces the binary
>> blob with the kernel, and the end-user compiles the code together and
>> loads it into the kernel, does that necessarily violate the GPL?
>>     
>
> The 'code that interfaces the binary blob with the kernel' would then be 
> illegal, because the code cannot be both GPL and proprietary. If the code is 
> GPL and acceptable for kernel-linking, then under the terms of the GPL, the 
> code cannot link to a GPL-incompatible binary blob.
>   
Not at all.  The linking interface code does not have to enforce GPL
restrictions until it is linked to GPL code.  It could be BSD, for
example, as much kernel code is.  BSD can link to binary blob without a
problem.  BSD can link to GPL without a problem.  The final result is a
undistributable bastard, but the end user will not be distributing.

Taken as separate pieces, the code cannot be illegal.  It is only by
arguing the intent to link to GPL code, and the distribution of the glue
and proprietary together that there would even be the possibility of
proving a license violation.  If that looked to be a possibility, all
nVidia, or anyone else would have to do is publish only their binary
blob along with instructions to third parties on how to create interface
glue.  Such a kernel module, written by a third party, to published
documentation, would clearly be an interface, not a link, and not
something the GPL could apply to.

So, you could _maybe_ stop people from directly providing proprietary
binaries plus glue modules in the same package, but you could not
prevent them from achieving the same result with a bit of extra effort.
