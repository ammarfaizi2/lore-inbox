Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130013AbRCDDUV>; Sat, 3 Mar 2001 22:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130017AbRCDDUK>; Sat, 3 Mar 2001 22:20:10 -0500
Received: from cvsftp.cotw.com ([208.242.241.39]:38152 "EHLO cvsftp.cotw.com")
	by vger.kernel.org with ESMTP id <S130013AbRCDDT4>;
	Sat, 3 Mar 2001 22:19:56 -0500
Message-ID: <3AA1B742.E8BF3BD2@cotw.com>
Date: Sat, 03 Mar 2001 21:32:18 -0600
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Tomt <andre@tomt.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LILO error with 2.4.3-pre1...
In-Reply-To: <OPECLOJPBIHLFIBNOMGBIEDHDGAA.andre@tomt.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Tomt wrote:
> 
> >    'lba32' extensions Copyright (C) 1999,2000 John Coffman
>      ^^^^^^
> 
> Add lba32 as the top line in lilo.conf. Re-run lilo.
> 
> > Fatal: geo_comp_addr: Cylinder number is too big (1274 > 1023)
> 
> Before 2.4.3pre1, your kernel just happened to toss itself below cylinder
> 1024.
> 
> > Go ahead, call me idiot :).
> 
> Idiot. :-)
> 
And since Andre was the last person to email me and call me an idiot,
I will reply to his response :). Yup, that was the case and I added
'lba32' to my '/etc/lilo.conf' and things work great. I knew it was
something simple, but I just don't pay attention to LILO much anymore.
Thanks everyone.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'http://www.cotw.com/pubkey.txt'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
