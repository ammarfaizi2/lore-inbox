Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292079AbSB0O03>; Wed, 27 Feb 2002 09:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292514AbSB0O0T>; Wed, 27 Feb 2002 09:26:19 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:33768 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S292511AbSB0O0H>; Wed, 27 Feb 2002 09:26:07 -0500
Message-ID: <3C7CEB5C.3000506@drugphish.ch>
Date: Wed, 27 Feb 2002 15:21:16 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: Zhu Ying Jie <zhuyingj@comp.nus.edu.sg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to disable TCP's checksum
In-Reply-To: <Pine.GSO.4.21.0202272215080.21508-100000@sf3.comp.nus.edu.sg>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Zhu Ying Jie wrote:
> Hi,
>   I am currently using kernel version 2.4.2 and trying to disable
> tcp_input's checksum function. However, even I comment all the csum_error
> in the file tcp_input.c, the packet (with wrong checksum) seems still will
> be dropped. Can anyone tell me how to do the work? 

You can try to set skb->ip_summed=CHECKSUM_UNNECESSARY. But read the 
comments in ../include/linux/skbuff.h to see if you really want that.

HTH,
Roberto Nibali, ratz

