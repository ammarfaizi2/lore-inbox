Return-Path: <linux-kernel-owner+w=401wt.eu-S1030698AbWLPH4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030698AbWLPH4t (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 02:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030706AbWLPH4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 02:56:49 -0500
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:44902 "EHLO
	rwcrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030698AbWLPH4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 02:56:48 -0500
Message-ID: <4583B748.2080809@wolfmountaingroup.com>
Date: Sat, 16 Dec 2006 02:07:20 -0700
From: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Olivier Galibert <galibert@pobox.com>,
       Andrew Robinson <andrew.rw.robinson@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ReiserFS corruption with 2.6.19 (Was 2.6.19 is not stable with
 SATA and should not be used by any meansis not stable with SATA and should
 not be used by any means)
References: <bc36a6210612121044vf259b34u4ec3cac4df56e43c@mail.gmail.com> <20061212224527.GA4045@dspnet.fr.eu.org> <20061215161544.GC4551@ucw.cz>
In-Reply-To: <20061215161544.GC4551@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>On Tue 12-12-06 23:45:27, Olivier Galibert wrote:
>  
>
>>On Tue, Dec 12, 2006 at 11:44:18AM -0700, Andrew Robinson wrote:
>>    
>>
>>>When I said hibernate, I did mention it was to disk, not to ram.
>>>      
>>>
>>Suspend to disk is not trustable on Linux, and does not look like it
>>will be any time soon.  Suspend to ram has a better chance of becoming
>>    
>>
>
>Stop spreading fud. Take powersave + suspend from suse10.2, and see
>if you can break it.
>
>sata_nv seems to have problem, that's it. and it triggered problem in
>reiserfs. Use ext3 if you care about your data, and yes your drivers
>need to support suspend/resume.
>							Pavel
>  
>
My Compaq laptop, a Presario 2200, has video lockups using suspend to 
disk and a dead system everytime I use it. I don't
think its fud. I also conceed its not Linux's fault most of the time. 
These vendors put Windows specific hardware support
into these systems. My laptop has a dozen strange keys that work only on 
Windows and if you push one of them in Linux,
the system looses state with the keyboard and croaks ( have to reboot to 
recover). If I close the lid of my latop or do any other
suspend to disk state, the video display is croaked.

Jeff
