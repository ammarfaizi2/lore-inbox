Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264253AbUEMPXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264253AbUEMPXr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbUEMPXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:23:47 -0400
Received: from main.gmane.org ([80.91.224.249]:25051 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264274AbUEMPWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:22:36 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ari Pollak <ajp@aripollak.com>
Subject: Re: 2.6.6-mm-rc3-mm2 USB 2.0 after suspend issue
Date: Thu, 13 May 2004 11:22:40 -0400
Message-ID: <40A392C0.5030101@aripollak.com>
References: <40A390B3.1020401@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: atlantis.ccs.neu.edu
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
In-Reply-To: <40A390B3.1020401@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.6-mm2 does indeed fix the EHCI problem and those messages; I guess I 
didn't read the patches closely enough. Instead, though, I have a new 
problem related to suspend/resume in 2.6.6-mm2 where an attached USB 
mouse will stop responding after a resume, but unplugging & plugging the 
device back in will work fine.
I was going to send a message off to usb-devel about it, but Thunderbird 
ended up losing my entire e-mail and I was too lazy to re-type it.

David Brownell wrote:
> Those messages are a bit strange.  If it still
> misbehaves in 2.6.6-mm2, please send "lspci -vv"
> info for these USB controllers.  (Preferably
> to linux-usb-devel, where it's easier to see.)
> 
>> ...
>> ehci_hcd 0000:00:1d.7: resume from state D0
>> ehci_hcd 0000:00:1d.7: can't resume, not suspended!
> 
> 
> Again, 2.6.6-mm2 shouldn't do that.
> 
> - Dave
> 
> 

