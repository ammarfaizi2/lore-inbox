Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbULQQPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbULQQPS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 11:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbULQQPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 11:15:17 -0500
Received: from alog0090.analogic.com ([208.224.220.105]:2688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261768AbULQQOu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 11:14:50 -0500
Date: Fri, 17 Dec 2004 11:11:37 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Bill Davidsen <davidsen@tmr.com>
cc: James Morris <jmorris@redhat.com>, Patrick McHardy <kaber@trash.net>,
       Bryan Fulton <bryan@coverity.com>, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [Coverity] Untrusted user data in kernel
In-Reply-To: <41C2FF99.3020908@tmr.com>
Message-ID: <Pine.LNX.4.61.0412171108340.4216@chaos.analogic.com>
References: <41C26DD1.7070006@trash.net> <Xine.LNX.4.44.0412170144410.12579-100000@thoron.boston.redhat.com>
 <41C2FF99.3020908@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2004, Bill Davidsen wrote:

> James Morris wrote:
>> On Fri, 17 Dec 2004, Patrick McHardy wrote:
>> 
>> 
>>> James Morris wrote:
>>> 
>>> 
>>>> This at least needs CAP_NET_ADMIN.
>>>> 
>>> 
>>> It is already checked in do_ip6t_set_ctl(). Otherwise anyone could
>>> replace iptables rules :)
>> 
>> 
>> That's what I meant, you need the capability to do anything bad :-)
>
> Are you saying that processes with capability don't make mistakes? This isn't 
> a bug related to untrusted users doing privileged operations, it's a case of 
> using unchecked user data.
>

But isn't there always the possibility of "unchecked user data"?
I can, as root, do `cp /dev/zero /dev/mem` and have the most
spectacular crask you've evet seen. I can even make my file-
systems unrecoverable.



Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
