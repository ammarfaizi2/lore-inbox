Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271711AbRIOBpd>; Fri, 14 Sep 2001 21:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271719AbRIOBpN>; Fri, 14 Sep 2001 21:45:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3090 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271711AbRIOBpC>; Fri, 14 Sep 2001 21:45:02 -0400
Message-ID: <3BA2B2A8.2010402@zytor.com>
Date: Fri, 14 Sep 2001 18:45:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: ISOFS corrupt filesizes
In-Reply-To: <E15i4GM-0001Iw-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>1 GB comes from the fact that some old CD's actually put garbage in
>>the upper byte of the file size, so the test triggers if the size is
>>larger than any CD can be.  Unfortunately, DVDs are a lot bigger than
>>CDs and that assumption is no longer correct.
>>
> 
> DVD is supposed to be using 1Gb files. I don't think its a
> big issue as we support UDF too
> 

Well, it's not all about DVDs used for video.  I think there are 
legitimate reasons to have very large files on a DVD-ROM, and they're 
likely to be encoded in iso9660 format (for maximum compatibility) as 
long as we don't have individual files > 4 GB.

	-hpa

