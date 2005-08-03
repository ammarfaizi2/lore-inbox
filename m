Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVHCJJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVHCJJV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 05:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVHCJJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 05:09:21 -0400
Received: from [195.144.244.147] ([195.144.244.147]:44191 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S262166AbVHCJJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 05:09:14 -0400
Message-ID: <42F089B6.8000304@varma-el.com>
Date: Wed, 03 Aug 2005 13:09:10 +0400
From: Andrey Volkov <avolkov@varma-el.com>
Organization: Varma Electronics Oy
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Greg KH <gregkh@suse.de>, Jamey Hicks <jamey.hicks@hp.com>,
       linux-kernel@vger.kernel.org, rpurdie@rpsys.net, tony.luck@intel.com,
       edwardsg@sgi.com
Subject: Re: [Linux-fbdev-devel] Re: Where is place of arch independed companion
 chips?
References: <42EB6A12.70100@varma-el.com> <42EE15AF.5050902@hp.com>	 <20050801181357.GA31144@suse.de> <1123019379.7782.86.camel@localhost.localdomain>
In-Reply-To: <1123019379.7782.86.camel@localhost.localdomain>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:
> On Mon, 2005-08-01 at 11:13 -0700, Greg KH wrote:
> 
>>>Good question.  I was about to submit a patch that created 
>>>drivers/platform because the toplevel driver for MQ11xx is a 
>>>platform_device driver.  Any thoughts on this?
>>
>>drivers/platform sounds good to me.
> 
> 
> In another thread (about the ucb1x00) we came up with the idea of
> drivers/mfd (mfd = multi function devices).
> 
> The core and platform specific parts would live here with suitable clear
> naming and the subsection specific parts that were separable would live
> in the appropriate place within the kernel.
> 
> Just another idea to add to the mix and removes the dilemma of a
> multifunction device with isn't platform based...
> 
drivers/mfd as drivers/mfd, I have not objections. Who will send the
patch first?

--
Regards
Andrey Volkov

P.S. Tony, Greg, may be it will someone from you? (I've in mind sn/ subdir)





