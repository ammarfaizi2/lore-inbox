Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264767AbUD1NEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbUD1NEb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 09:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbUD1NEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 09:04:31 -0400
Received: from mail.tmr.com ([216.238.38.203]:35080 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S264767AbUD1NEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 09:04:30 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: USB related oops in 2.6.6-rk2-bk3 (similar with 2.6.5)
Date: Wed, 28 Apr 2004 09:05:50 -0400
Organization: TMR Associates, Inc
Message-ID: <c6o9vn$4rr$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.58.0403272228360.2662@alpha.polcom.net> <Pine.LNX.4.58.0404270115260.5772@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1083157303 4987 192.168.12.100 (28 Apr 2004 13:01:43 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.58.0404270115260.5772@alpha.polcom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski wrote:
> Hi,
> 
> I experienced this oops. I have uhci-hcd and two devices. One is usb 
> camera (TC111 - probably not supported under linux?) and the 
> second is speedtouch modem. Everytime I shut down my system (Gentoo) with 
> 2.6.5 and newer I get some oops but system log is down before that and I 
> have no time to hack start scripts to stop shuting syslog. It occures when  
> removing some usb modules. So I stopped speedtouch and removed the modules 
> manually (in stop scripts order I hope). But I have not removed uhci-hcd 
> module (this module is removed in other part of stop scripts). And... 
> nothing happened. So I unplugged speedtouch and replugged it back. And I 
> immendiatelly got atached oops. (I think that I should use ksymoops, but 
> it is searching for /proc/ksyms that is not present in 2.6 and it does not 
> like /proc/kallsyms... And it produces nothing but warnings. What options 
> should I use?)
> 
> What can I do to help track the problem down?

Does it happen without preempt?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
