Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVCUWfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVCUWfl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVCUWdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:33:14 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:56511 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262105AbVCUW2n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:28:43 -0500
Message-ID: <423F4BF2.8050603@tmr.com>
Date: Mon, 21 Mar 2005 17:34:26 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1 report
References: <200503191503.26128.gene.heskett@verizon.net>
In-Reply-To: <200503191503.26128.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> Greetings;
> 
> Usually I come looking for a bone when I post here, but today its with 
> verbal flowers in hand.
> 
> I just built 2.6.12-rc1 and I'm pleased to report that the ieee1394 
> problems that required the bk-ieee1394.patch previously are 
> apparently alleviated.  Kino worked as expected, including the audio 
> from the cameras microphones.
> 
> tvtime, with my pcHDTV-3000 card, had a miss-cue due to the wrong 
> modprobe statement in my rc.local, so I cleaned out those modules 
> that it had loaded, and reloaded them with the 'modprobe cx88_dvb' 
> statement, which brought that up with working video but raw noise for 
> audio at about +40db!  Going into its menu's for tv standards I chose 
> to 'restart with new values' without changing anything which restored 
> the audio to normal.  Thats happened before, and Jack tells me there 
> will be another coding session this weekend so there will no doubt be 
> more patches for that.  This FWIW, was without actually installing 
> either version of his drivers, so this is nice progress.
> 
> My scanner works normally. As does the spca5xx stuffs that I did 
> install again after the boot.

What distro are you using with this? Before I report problems I want to 
eliminate distro errors of the type you describe.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
