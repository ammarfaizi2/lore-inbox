Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVEZXrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVEZXrv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 19:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVEZXru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 19:47:50 -0400
Received: from butter.kernelcode.com ([216.254.126.222]:775 "HELO
	butter.kernelcode.com") by vger.kernel.org with SMTP
	id S261854AbVEZXra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 19:47:30 -0400
Subject: Re: Tyan Opteron boards and problems with parallel ports (badpmd)
From: Christopher Warner <cwarner@kernelcode.com>
To: chris@servertogo.com, "Peter J. Stieber" <developer@toyon.com>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <022e01c56233$241e5930$1600a8c0@toyon.corp>
References: <3174569B9743D511922F00A0C943142309F815A6@TYANWEB>
	 <037801c5616a$b1be6600$1600a8c0@toyon.corp> <4295E9F1.6080304@tmr.com>
	 <022e01c56233$241e5930$1600a8c0@toyon.corp>
Content-Type: text/plain
Date: Thu, 26 May 2005 19:47:24 -0400
Message-Id: <1117151244.8874.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you give any information on the badpmd problem? There is a thread
about the badpmd problem and a couple of patches you might want to use
to get some debug information. I also suspect that it might have
something to do with the actual motherboard but people have reported
badpmds on other mobos.

I've put it down for now but the more info the better :-)  I've
experienced problems with badpmds under load io, mem etc. Sometimes it
appears with little load.

On Thu, 2005-05-26 at 13:40 -0700, Peter J. Stieber wrote:
> YhLu>>> Don't always blame BIOS, if you like you could
> YhLu>>> use LinuxBIOS instead...
> 
> PJS>> Just curious, but why isn't this project (LinuxBIOS)
> PJS>> mentioned on the Tyan web site, or is it and I
> PJS>> just missed it?
> PJS>>
> PJS>> You do work for Tyan, right?
> 
> BD = Bill Davidsen
> BD> What has that to do with anything? I doubt that suggestions
> BD> about boot options are on the website or come from the
> BD> Tyan website, either.
> BD>
> BD> Note: I'm not endorsing LinuxBIOS for Opteron, I haven't
> BD> personally tried it. But the value of the suggestion depends
> BD> on how it works, not who makes it. There appear to be a
> BD> lot of reports of problems with Opteron lately, if the BIOS
> BD> isn't buggy then the documentation may have lost in
> BD> translation.
> 
> I have been having the "memory.c bad pmds" with a Tyan S2885 
> motherboard.
> 
> https://www.redhat.com/archives/fedora-list/2005-May/msg01690.html
> http://www.lib.uaa.alaska.edu/linux-kernel/archive/2005-Week-19/1397.html
> 
> When Yhlu brought up the topic of LinuxBIOS, I thought he might be 
> suggesting that this would prove there are no problems with the BIOS 
> (i.e. the same problems would occur with LinuxBIOS as with the 
> motherboards built-in BIOS). Looking at the LinuxBIOS web site, I got 
> the impression (I may be wrong) that this was a Tyan supported effort. 
> If that was the case I was wondering why Tyan didn't mention LinuxBIOS 
> on their web site. It would make me more comfortable if this were a Tyan 
> supported effort. That's why I asked the question.
> 
> I'm just trying anything I can to get rid of the bad pmd messages.
> 
> Pete 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

