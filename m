Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135590AbRALXep>; Fri, 12 Jan 2001 18:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135571AbRALXe0>; Fri, 12 Jan 2001 18:34:26 -0500
Received: from sc-66-27-47-84.socal.rr.com ([66.27.47.84]:12807 "EHLO
	falcon.bellfamily.org") by vger.kernel.org with ESMTP
	id <S135619AbRALXeS>; Fri, 12 Jan 2001 18:34:18 -0500
Message-ID: <3A5F9491.20109@bellfamily.org>
Date: Fri, 12 Jan 2001 15:34:41 -0800
From: "Robert J. Bell" <rob@bellfamily.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
CC: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: USB Mass Storage in 2.4.0
In-Reply-To: <3A5F8956.9040305@bellfamily.org> <20010112151008.A5798@one-eyed-alien.net> <3A5F9108.4030706@bellfamily.org> <20010112152415.B5798@one-eyed-alien.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately I lost everything on my system (the one that worked) and I 
don't believe I ever looked in /proc/scsi/scsi because It was working 
and I didn't feel the need to go poking around.  I had this problem 
initially the first time I compiled 2.4.0 but I went back and added SCSI 
Generic "on" and that seemed to fix it.  I am just confused why it 
thinks this is a scanner. IS there any way to force it to detect it as a 
scsi disk?

I must have recompiled this kernel 50 times trying to recreate the the 
scenario where this worked. I can send you my .config if you think that 
will help.

Robert





Matthew Dharm wrote:

> Hrm... from these logs, everything looks okay, except for the fact that the
> device refuses to return any INQUIRY data.
> 
> Can you reproduce the conditions under which it was working and send logs
> from that?  Or at least remember what the /proc/scsi/scsi info looked like?
> 
> Matt
> 
> On Fri, Jan 12, 2001 at 03:19:36PM -0800, Robert J. Bell wrote:
> 
>> Matthew here is the info you requested, thanks for your help.
>> 
>> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
