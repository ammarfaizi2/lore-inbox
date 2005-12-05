Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVLFRCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVLFRCA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVLFRCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:02:00 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:16951 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932370AbVLFRB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:01:59 -0500
Message-ID: <4394AF89.4000408@tmr.com>
Date: Mon, 05 Dec 2005 16:22:17 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Rob Landley <rob@landley.net>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>	 <4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de>	 <200512042131.13015.rob@landley.net>  <4394681B.20608@rtr.ca> <1133800090.21641.17.camel@mindpipe>
In-Reply-To: <1133800090.21641.17.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Mon, 2005-12-05 at 11:17 -0500, Mark Lord wrote:
> 
>>>>>Ahh OK .. I don't use it, so wouldn't have been affected. That's one
>>>>>userspace interface broken during the series, does anyone have any more?
>>
>>Ah.. another one, that I was just reminded of again
>>by the umpteenth person posting that their wireless
>>no longer is WPA capable after upgrading from 2.6.12.
>>
>>Of course, the known solution for that issue is to
>>upgrade to the recently "fixed" latest wpa_supplicant
>>daemon in userspace, since the old one no longer works.
>>
>>Things like this are all too regular an occurance.
> 
> 
> The distro should have solved this problem by making sure that the
> kernel upgrade depends on a new wpa_supplicant package.  Don't they
> bother to test this stuff before they ship it?!?

Could you provide a little detail on the technology by which a distro 
checks for functionality against a kernel which wasn't necessarily 
released when the distro shipped. My udev doesn't generate /dev/timewarp.

Going to a new kernel in the same series shouldn't have to be treated as 
if it were a change to a whole new operating system, and shouldn't 
require completely replacing existing utilities with new ones which 
aren't backware compatible to allow fallback to the original kernel.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

