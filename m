Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUFGILz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUFGILz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 04:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUFGILz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 04:11:55 -0400
Received: from mail.scienion.de ([141.16.81.54]:28085 "EHLO
	server03.hq.scienion.de") by vger.kernel.org with ESMTP
	id S262106AbUFGILw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 04:11:52 -0400
Message-ID: <40C42344.30908@scienion.de>
Date: Mon, 07 Jun 2004 10:11:48 +0200
From: Sebastian Kloska <kloska@scienion.de>
Reply-To: kloska@scienion.de
Organization: Scienion AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
X-MIMETrack: Itemize by SMTP Server on SrvW2k01/Scienion(Release 6.5.1|January 28, 2004) at
 07.06.2004 10:20:50,
	Serialize by Router on SrvW2k01/Scienion(Release 6.5.1|January 28, 2004) at
 07.06.2004 10:20:53,
	Serialize complete at 07.06.2004 10:20:53
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Denis Vlasenko wrote:

>On Saturday 05 June 2004 20:18, Sebastian Kloska wrote:
>  
>
>> Thanks for the patch
>>
>> Unfortunately that didn't do the trick. It does not even suspend
>> sometimes when hitting the suspend button. This is very strange.
>> It reproducible does not resume the second time.  Seems like
>> the system has been left in an unstable state after the first
>> suspend/resume cycle. I'm definitely not the born hardware/BIOS
>> programmer although I have been involved in graphic device
>> programming (a pain) but in this this case which is a real pain I
>> would be willing to at least help by further debugging the issue.
>> Kernel 2.4.x proved that the BIOS can be talked into properly
>> interacting with linux. So it's at least not totally brain dead.
>>
>> One might argue that the hardware is already a little bit out dated
>> but I really do not have the resources to buy a new
>> laptop every year and  it  also represents some kind of masochistic
>> challenge to get this thing going.  But I really do not know how
>> to debug the stuff or where to look.
>>
>> Any hints how to proceed would be highly appreciated
>>    
>>
>
>  
>
>Well, typically I pepper source with printks, rebuild kernel,
>reboot, set loglevel to max, watch the log, crash, repeat.
>  
>
    Realy was afraid you say something like this. Now I'll follow
    Michael Clarks recommentation of ripping down the kernel
    to minimal functionality and add drivers/moduls until I hit
    the 'bad' one. ... keep you informed

>--
>vda
>
>  
>



-- 
**********************************
Dr. Sebastian Kloska
Head of Bioinformatics
Scienion AG
Volmerstr. 7a
12489 Berlin
phone: +49-(30)-6392-1708
fax:   +49-(30)-6392-1701
http://www.scienion.de
**********************************
