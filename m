Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279891AbRKBA6A>; Thu, 1 Nov 2001 19:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279884AbRKBA5l>; Thu, 1 Nov 2001 19:57:41 -0500
Received: from sitar.i-cable.com ([210.80.60.11]:33993 "HELO sitar.i-cable.com")
	by vger.kernel.org with SMTP id <S279888AbRKBA5j>;
	Thu, 1 Nov 2001 19:57:39 -0500
Message-ID: <3BE298E3.4090905@rcn.com.hk>
Date: Fri, 02 Nov 2001 21:00:19 +0800
From: David Chow <davidchow@rcn.com.hk>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-GB; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-gb
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: FORT David <popo.enlighted@free.fr>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Oops on 2.4.13
In-Reply-To: <1235.1004655139@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have no output for modinfo even running kernel 2.4.2 .. what's the 
problem here?

Thanks.

DC

Keith Owens wrote:

>On Thu, 01 Nov 2001 16:45:04 -0500, 
>FORT David <popo.enlighted@free.fr> wrote:
>
>>the kernel is tainted but by a kernel driver which hasn't set
>>any licence(can't remember which one)
>>
>
>modinfo `modprobe -l` | sed -ne '/^filename/h; /^license.*none/{g;p;}'
>
>lists all modules without a license, please report so it can be fixed.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


