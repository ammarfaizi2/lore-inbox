Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTL2CEg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 21:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTL2CEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 21:04:36 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:33700 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S262321AbTL2CEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 21:04:35 -0500
Message-ID: <3FEF8BB1.6090704@wmich.edu>
Date: Sun, 28 Dec 2003 21:04:33 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Walt H <waltabbyh@comcast.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Can't eject a previously mounted CD?
References: <3FEF89D5.4090103@comcast.net>
In-Reply-To: <3FEF89D5.4090103@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd have to say the december 17th listed changes are the culprit here. 
I'm definitely not up to figuring out what change is the bad one.  If 
any of the cdrom/ide-cd people wanna have me get some data from them 
then just tell me how.  I've tried viewing the debug output from the 
modules with no success in figuring out the problem.


Walt H wrote:
>>Does everyone who has this problem by chance have it occuring on an 
>>atapi cd recorder.  As of 2.6.0-mm1 my cd recorder is being labeled read 
>>only by the ide-cd driver.  Meaning, no matter if i set the readonly 
>>flag in hdparm to 0, cdrecord and others will refuse to write to the 
>>drive because it's being told it's read only.  I do not have fam loaded 
>>at the time of this testing.  Are there new ide-cd arguments required to 
>>use atapi cd writers in native mode?
>>
>>
> 
> 
> I have it happening on both my optical drives. One is a lite-on ATAPI cd-rw, the
> other an ATAPI Pioneer dvd-rw/cd-rw.  No fam/gnome running. I do use automount
> with these drives, but I can see that the mounts have been expired, yet I can't
> eject them using the button. Tested last night using both ide-cd and ide-scsi.
> Same result with either access. When they're locked, fuser shows nothing
> attached, as does lsof. I can eject them with the eject command.
> 
> -Walt


