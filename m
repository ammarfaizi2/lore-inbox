Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbVKAX21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbVKAX21 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 18:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbVKAX21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 18:28:27 -0500
Received: from smtpout.mac.com ([17.250.248.46]:48877 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751434AbVKAX20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 18:28:26 -0500
In-Reply-To: <4367E1CA.9040400@tmr.com>
References: <53JVy-4yi-19@gated-at.bofh.it> <545a6-2GZ-17@gated-at.bofh.it> <43679B8F.8000305@gmail.com> <43679FFB.6040504@mnsu.edu> <4367A369.5030003@gmail.com> <1130872775.22089.1.camel@mindpipe> <4367E1CA.9040400@tmr.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C40C872A-9CE5-4832-94B6-FAC26A403AF7@mac.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>,
       "Kernel," <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [BUG 2579] linux 2.6.* sound problems (SOLVED)
Date: Tue, 1 Nov 2005 18:28:20 -0500
To: Bill Davidsen <davidsen@tmr.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 1, 2005, at 16:44:42, Bill Davidsen wrote:
> Go back and reread the thread in the archives. The short answer is  
> that he who controls the code controls the decisions. I just fix it  
> everywhere, since 250 is too fast for optimal battery life, too  
> slow for optimal response or multimedia, and not optimal for any  
> server application I run (usenet, dns, mail, http, firewall).
>
> A perfect compromise is one which makes everyone reasonably happy;  
> this is like the XOR of that, it leaves everyone slightly  
> dissatisfied. ;-)
>
> I'm convinced that Linus choose this value to make everyone  
> slightly unhappy, so development of various variable rate and tick  
> skipping projects would continue. Unfortunately that doesn't seem  
> to have happened :-(

No, I think it's been happening, it's just that said developers are  
still fixing the copious bugs in the various kernel concepts of  
"time".  IIRC John Stultz' rework is approaching completion, and when  
that goes in it makes life a lot easier for the various dyntick and  
variable tick projects.

Cheers,
Kyle Moffett

--
Unix was not designed to stop people from doing stupid things,  
because that would also stop them from doing clever things.
   -- Doug Gwyn


