Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263477AbTCNUA7>; Fri, 14 Mar 2003 15:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263480AbTCNUA7>; Fri, 14 Mar 2003 15:00:59 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:63150 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S263477AbTCNUA5>; Fri, 14 Mar 2003 15:00:57 -0500
Message-ID: <3E7235B7.5050407@nortelnetworks.com>
Date: Fri, 14 Mar 2003 15:04:07 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, kai@tp1.ruhr-uni-bochum.de
Subject: Re: Kernel setup() and initrd problems
References: <Pine.GHP.4.53.0303130942100.16619@alderaan.science-computing.de> <Pine.LNX.4.44.0303131051160.7342-100000@chaos.physics.uiowa.edu> <b4t9i6$eon$1@cesium.transmeta.com> <3E722D31.6050702@nortelnetworks.com> <3E7230D2.7010309@zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Chris Friesen wrote:
> 
>>
>> Below is the script that I used to pivot from a standard ramdisk (for 
>> with
>> the infrastructure is already in place in our build environment) to a 
>> tmpfs
>> filesystem.  This requires no changes to the boot args.

> ... which means that you either have boot args or rdev so that /dev/ram0 
> is the root filesystem (or it wouldn't work.)

Yes, but after the pivot, /dev/ram0 isn't the real filesytem, its tmpfs
mounted at /.  Isn't that what the original poster was talking about,
where the root on the final running system is not the same as what the
machine was booted with?

Maybe I'm just confused.


Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

