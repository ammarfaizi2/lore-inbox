Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266878AbUJWFyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUJWFyO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 01:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266838AbUJWEYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:24:15 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:42193 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S266837AbUJWESp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:18:45 -0400
Message-ID: <4179DBA3.2000407@verizon.net>
Date: Sat, 23 Oct 2004 00:18:43 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Kurt Wall <kwall@kurtwerks.com>, linux-kernel@vger.kernel.org, pj@sgi.com
Subject: Re: mozilla-mail damage [was Re: [PATCH] Update to	Documentation/ramdisk.txt
 - take 2]
References: <4179B7A9.6020205@verizon.net>	 <20041023021227.GF4368@kurtwerks.com>	 <1098498910.9092.8.camel@krustophenia.net> <1098501410.9092.36.camel@krustophenia.net>
In-Reply-To: <1098501410.9092.36.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [209.158.211.53] at Fri, 22 Oct 2004 23:18:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Fri, 2004-10-22 at 22:35 -0400, Lee Revell wrote:
> 
>>On Fri, 2004-10-22 at 22:12 -0400, Kurt Wall wrote:
>>
>>>On Fri, Oct 22, 2004 at 09:45:13PM -0400, Jim Nelson took 229 lines to write:
>>>
>>>>@#%*^#$ Mozilla.  Line wrap was set too low.
>>>>
>>>>Let's try this again - hopefully, Mozilla won't mangle my patch this time.
>>>
>>>Urgl:
>>>
>>>patching file Documentation/ramdisk.txt
>>>Hunk #1 FAILED at 5.
>>
>>You cannot just increase the line wrap and hope Mozilla will do the
>>right thing.  Mozilla should have an option to insert preformatted text.
> 
> 
> OK I just went and installed mozilla mail to see what the problem is and
> it's worse than I thought.
> 
> The problem is that Mozilla does not grok the standard X clipboard at
> all.
> 
> Try these tests:
> 
> 1. Highlight some text in an xterm.  Paste with middle button into
> Mozlla  mail window.  Then paste with the middle button into vim.  Both
> work BUT the patch is whitespace damaged.
> 
> 2. Run diff foo bar | xclip.  Paste with middle button into Mozilla.
> Nothing.  Then paste with middle button into vim.  Works.
> 
> #2 would not mangle the patch IF it worked which it doesn't.  Mozilla
> does not have a setting to insert a text file.  So many people just do
> #1.
> 
> No wonder people are mangling patches, the Mozilla mail client is very
> broken.  PLEASE, file bug reports!
> 
> Lee
> 
>

Probably need to make using Paul Jackson's sendpatchset script de riguer 
recommendation for GUI mail client users for right now, until this issue is hashed 
out one way or another.

However, sendpatchset doesn't work with SMTP authentication, which my ISP uses, 
and I'm too tired to get sendmail working on one of my machines tonight.  Maybe 
sometime tomorrow.
