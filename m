Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWBAAOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWBAAOi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 19:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWBAAOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 19:14:37 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:29407 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751232AbWBAAOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 19:14:37 -0500
Message-ID: <43DFFDBC.7010401@tmr.com>
Date: Tue, 31 Jan 2006 19:15:56 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, bzolnier@gmail.com, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future
 Linux (stirring up a hornets' nest) ]
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <43DCA097.nailGPD11GI11@burner> <20060129112613.GA29356@merlin.emma.line.org> <Pine.LNX.4.61.0601292139080.2596@yvahk01.tjqt.qr> <43DD2A8A.nailGVQ115GOP@burner> <787b0d920601291328k52191977h37 <43DE495A.nail2BR211K0O@burner> <43DE75F5.40900@cfl.rr.com> <43DF403F.nail2RF310RP6@burner>
In-Reply-To: <43DF403F.nail2RF310RP6@burner>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> Phillip Susi <psusi@cfl.rr.com> wrote:
> 
> 
>>Joerg Schilling wrote:
>>
>>>I am sorry to see your recent dicussion style.
>>>
>>>I was asking a question and I did get a completely useless answer as
>>>any person who has some basic know how Linux SCSI would know that
>>>doing a stat("/dev/sg*", ...) will not return anything useful.
>>>  
>>
>>It certainly does return something useful, just not what you are looking 
>>for.  It does not return information that allows you to cleanly build 
>>your bus:device:lun view of the world, but it does return sufficient 
>>information to enumerate and communicate with all devices in the 
>>system.  Is that not sufficient to be able to implement cdrecord?  If it 
>>is, then the real issue here is that you want Linux to conform to the 
>>bus:device:lun world view, which it seems many people do not wish to do. 
> 
> 
> It does not allow libscg to find all devices.
> 
> 
>>Maybe it would be more constructive if you were to make a good argument 
>>for why the bus:device:lun view is better than /dev/*, but right now it 
>>seems to me that they are just two different ways of doing the same 
>>thing, and you prefer one way while the rest of the Linux developers 
>>prefer the other. 
> 
> 
> It would help if someone would give arguments why Linux does treat all 
> SCSI devices equal, except for ATAPI transport based ones.

That's a fair question, which I asked in a seperate thread. Everything 
in the system which looks like a block device, tape or optical device 
looks like SCSI except ATAPI.

However, as my mother used to say "those are the conditions which 
prevail," so perhaps it's time to accept it and move on.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
