Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263303AbTDCG7o>; Thu, 3 Apr 2003 01:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263305AbTDCG7o>; Thu, 3 Apr 2003 01:59:44 -0500
Received: from ns.conceptual.net.au ([203.190.192.15]:60068 "EHLO
	conceptual.net.au") by vger.kernel.org with ESMTP
	id <S263303AbTDCG7n>; Thu, 3 Apr 2003 01:59:43 -0500
Message-ID: <3E8BDDA9.2080508@seme.com.au>
Date: Thu, 03 Apr 2003 15:07:21 +0800
From: Brad Campbell <brad@seme.com.au>
User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stewart Smith <stewartsmith@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: Synaptics Touchpad loses sync 2.5.66
References: <3E8BCB4F.5080900@seme.com.au> <18037.130.194.13.164.1049353252.squirrel@127.0.0.1>
In-Reply-To: <18037.130.194.13.164.1049353252.squirrel@127.0.0.1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SFilter: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stewart Smith wrote:
> Brad Campbell said:
> 
>>G'day all,
>>This is the show stopper for me using 2.5.x
>>I have seen this since the first 2.5.x kernel I tried which was around
>>2.5.42.
>>Under X 4.2.0 (Happened under 4.1.x also) the Touchpad loses sync quite
>> frequently causing the mouse to go haywire, jumping all over the
>>screen  and sending button presses that I have not made.
>>The exact same configuration works perfectly under 2.4.x
> 
> 
> I would argue that their is something marjorly funny with the synaptics
> touchpads themselves (in some scenareos at least). I have seen this
> *exact* behaviour not only on linux (2.4, mandrake) but in Win98 and
> Win2k. This was a Dell Inspiron 4000 which my gf of the time had. She's

Yep, I had a similar problem on my old Gateway Solo 2150 that was 
rectified by a bios upgrade. Under windows it would happen rarely, but 
it did occur, under Linux it was unusable. A bios upgrade for the 
keyboard controller fixed both :p)
In this case, it is caused by polling ACPI status. Only under 2.5 
though, 2.4 works perfectly.


-- 
Brad....
  /"\
  \ /     ASCII RIBBON CAMPAIGN
   X      AGAINST HTML MAIL
  / \

