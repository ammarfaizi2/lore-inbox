Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVEKBW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVEKBW3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 21:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVEKBW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 21:22:28 -0400
Received: from quark.didntduck.org ([69.55.226.66]:46522 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261871AbVEKBWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 21:22:07 -0400
Message-ID: <42815E63.5020508@didntduck.org>
Date: Tue, 10 May 2005 21:22:43 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.2-1 (X11/20050323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Per Liden <per@fukt.bth.se>
CC: Greg KH <gregkh@suse.de>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
References: <20050506212227.GA24066@kroah.com> <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se> <20050509211323.GB5297@tsiryulnik> <Pine.LNX.4.63.0505102351300.8637@1-1-2-5a.f.sth.bostream.se> <20050510224112.GA4967@kroah.com> <Pine.LNX.4.63.0505110057550.20513@1-1-2-5a.f.sth.bostream.se>
In-Reply-To: <Pine.LNX.4.63.0505110057550.20513@1-1-2-5a.f.sth.bostream.se>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per Liden wrote:
> On Tue, 10 May 2005, Greg KH wrote:
> 
> 
>>On Wed, May 11, 2005 at 12:17:12AM +0200, Per Liden wrote:
>>
>>>I'd like to get a better understanding of that as well. Why invent a 
>>>second on demand module loader when we have kmod? The current approach 
>>>feels like a step back to something very similar to the old kerneld.
>>
>>kmod is not used at all if you are running udev on your system.
> 
> 
> Since when does udev load modules for you? And how would it know when to 
> load "device less" modules such as filesystems?
> 
> 
>>It's also better to allow userspace to make the decision as to if it 
>>should load a specific module or not, not the kernel.
> 
> 
> If you don't want a specific module to be loaded, then don't build it. 
> You just said that yourself in the blacklisting dicsussion remember? ;)
> (hint: "Don't build the OSS modules at all?").

Think about distibution kernels that build everything possible.

--
				 Brian Gerst
