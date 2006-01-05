Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752124AbWAEJSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbWAEJSr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 04:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbWAEJSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 04:18:46 -0500
Received: from smtpout.mac.com ([17.250.248.88]:57829 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1752124AbWAEJSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 04:18:45 -0500
In-Reply-To: <43BCCE69.1020509@uplinklabs.net>
References: <20060105004826.GA17328@kroah.com> <Pine.LNX.4.64.0601041724560.3279@g5.osdl.org> <20060105020742.GA18815@suse.de> <Pine.LNX.4.64.0601041836370.3279@g5.osdl.org> <20060105033152.GA23380@suse.de> <Pine.LNX.4.64.0601041935070.3169@g5.osdl.org> <20060105034414.GA23660@suse.de> <43BCCE69.1020509@uplinklabs.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6AAE697F-67B0-4976-B7D1-A87C441F4490@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: devfs going away, last chance to complain (was Re: [GIT PATCH] Driver Core patches for 2.6.15)
Date: Thu, 5 Jan 2006 04:18:40 -0500
To: Steven Noonan <steven@uplinklabs.net>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 05, 2006, at 02:44, Steven Noonan wrote:
> Pardon my ignorance, but what precisely was/is the problem with  
> devfs, anyway?

1) It had unfixable races  (The device is created when the hardware  
is detected but the module isn't loaded yet so the device doesn't work?)
2) The maintainer stopped maintaining it
3) It put naming policy (and a bad one at that) in the kernel where  
it doesn't belong.

I'm sure there are more, but those are the basic ones.

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/ 
philosophy/) software stuff and not get a real job. Charles Schulz  
had the best answer:

"Why do musicians compose symphonies and poets write poems? They do  
it because life wouldn't have any meaning for them if they didn't.  
That's why I draw cartoons. It's my life."
   -- Charles Schulz


