Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbRB1VFP>; Wed, 28 Feb 2001 16:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129216AbRB1VFG>; Wed, 28 Feb 2001 16:05:06 -0500
Received: from asbestos.brocade.com ([63.121.140.244]:16494 "EHLO
	mail.brocade.com") by vger.kernel.org with ESMTP id <S129213AbRB1VEs>;
	Wed, 28 Feb 2001 16:04:48 -0500
Message-ID: <3A9D68FE.80104@brocade.com>
Date: Wed, 28 Feb 2001 13:09:18 -0800
From: Amit D Chaudhary <amitc@brocade.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac5 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: mke2fs hangs while running on /dev/loop0 - kernel version 2.4
In-Reply-To: <3A9C6184.9050802@brocade.com> <20010227214614.A13399@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Thanks every much for the pointer. Yes, with 2.4.2-ac5 the problem is gone.
Also, there was another similar problem with lilo stalling that is gone too.

Regards
Amit

Arnaldo Carvalho de Melo wrote:

> Em Tue, Feb 27, 2001 at 06:25:08PM -0800, Amit D Chaudhary escreveu:
> 
>> I am hoping someone knows more about this case. I have a intel pc 
>> running linux 2.4 and the last command below hangs and the statements as 
>> they are printed. Even kill -9 does not get it to terminate.
>> 
>> #touch img.test
>> #dd if=/dev/zero of=img.test bs=1k count=2000
>> 2000+0 records in
>> 2000+0 records out
>> #losetup /dev/loop0 img.test
>> #mke2fs
>> 
> 
> 
> known bug, try 2.4.2-ac5 (ac6 seems to have some small problems,
> Keith seems to have fixed with a patch some moments ago) some friends of
> mine said 2.4.2-ac seems to make loop behave, haven't checked
> 
> - Arnaldo


