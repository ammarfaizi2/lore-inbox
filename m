Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264795AbSKEKrO>; Tue, 5 Nov 2002 05:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264805AbSKEKrO>; Tue, 5 Nov 2002 05:47:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35346 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264795AbSKEKpW>; Tue, 5 Nov 2002 05:45:22 -0500
Message-ID: <3DC7A2B1.3050402@zytor.com>
Date: Tue, 05 Nov 2002 02:51:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reconfiguring one SW-RAID when other RAIDs are running
References: <3DC762FC.8070007@zytor.com> <15815.32292.689774.895238@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Monday November 4, hpa@zytor.com wrote:
> 
>>Hi all,
>>
>>I'm trying to re-create a RAID while leaving the other RAIDs -- 
>>including the root filesystem -- running, but mkraid refuses to run:
>>
>>hera 1 # mkraid /dev/md2
>>/dev/md0: array is active -- run raidstop first.
>>mkraid: aborted.
>>(In addition to the above messages, see the syslog and /proc/mdstat as well
>>  for potential clues.)
> 
> 
> I cannot offer any help on using mkraid, except to avoid it :-(
> mdadm is (I believe and others agree) much easier to use.
>   http://www.cse.unsw.edu.au/~neilb/source/mdadm/
> 
> It is definately being maintained, not that it has needed much...
> 

I actually ended up using mdadm... I actually dislike it not using the 
raidtab file at least as an option; I find the raidtab file to be good 
documentation for what one had done.   I would prefer for mkraid to get 
fixed, if it hasn't already.

> 
>>(Also note: the raid directory on kernel.org seems to be abandoned. 
>>Unless someone speaks up I'm going to remove it.)
>>
> 
> 
> Again, I cannot comment on this directory, but would there be any
> change of getting somewhere on kernel.org to distribute mdadm??
> 

Absolutely... send a GPG key to ftpadmin@kernel.org.

	-hpa

