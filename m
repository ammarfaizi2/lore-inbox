Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUIWT5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUIWT5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 15:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUIWT5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 15:57:11 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:4020 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264503AbUIWT5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 15:57:05 -0400
Message-ID: <41532A92.5080305@myrealbox.com>
Date: Thu, 23 Sep 2004 12:57:06 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sourceforge.net>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@muc.de,
       gandalf@wlug.westbo.se
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
References: <1095962839.4974.965.camel@cube>	 <41532504.3000005@nortelnetworks.com> <1095968193.4969.980.camel@cube>
In-Reply-To: <1095968193.4969.980.camel@cube>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> On Thu, 2004-09-23 at 15:33, Chris Friesen wrote:
> 
>>Albert Cahalan wrote:
>>
>>
>>>Who is doing a 32-bit userland on x86-64, and WTF for?
>>>Why do they not also run a 32-bit kernel?
>>
>>Backwards compatibility?  Desire to run binary-only 32-bit software as well as 
>>64-bit software on the same kernel?
> 
> 
> Nope. For that, you run 99% 64-bit, including iptables.
> That's what is typically done. So you'd have a 32-bit
> OpenOffice maybe, and everything else is 64-bit.
> 
> I'm still not seeing a need to run an x86-64 kernel
> with an i386 iptables.
> 
> 

Easy migration: take your fully-set-up server image, throw in an Opteron 
with 16GB RAM, and boot a 64-bit kernel.  As long as you don't need more 
than 4GB/program, you're set.  Except your firewall is broken.

--Andy
