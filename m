Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbSJUGbc>; Mon, 21 Oct 2002 02:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbSJUGbb>; Mon, 21 Oct 2002 02:31:31 -0400
Received: from [80.66.10.42] ([80.66.10.42]:29149 "EHLO
	woodstock.orga-systems.de") by vger.kernel.org with ESMTP
	id <S264745AbSJUGba>; Mon, 21 Oct 2002 02:31:30 -0400
Message-ID: <3DB3A112.1060003@orga.com>
Date: Mon, 21 Oct 2002 08:39:14 +0200
From: =?ISO-8859-1?Q?Gerrit_Bruchh=E4user?= <gbruchhaeuser@orga.com>
Organization: ORGA Kartensysteme GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.1) Gecko/20020826
X-Accept-Language: de, en-us
MIME-Version: 1.0
To: Sean Estabrooks <seanlkml@rogers.com>
CC: linux-kernel@vger.kernel.org, landley@trommello.org, alan@redhat.com,
       ankry@green.mif.pg.gda.pl, torvalds@transmeta.com
Subject: Re: bootsect.S and magic address 0x78
References: <3DAFDC88.2010009@orga.com> <0d8c01c276a6$67cf9020$370a0a0a@slappy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sean,

thank you very much - you realy helped me a lot. I wrote to the top 
because this question had been already posted many times. See for 
instances: http://www.leto.net/mail/linuxasm/2001/msg00538.html

If this is ok for you then I would like to copy+paste your answer to all 
these postings I crossed.

Many thanks and cheers!

Gerrit


Sean Estabrooks schrieb:

>>Hello Linus,
>>
>>
>>Can you tell me where this magic address 0x78 in arch/i386/bootsect.S
>>refers to? I mean, is this somewhere specified?
>>
>>Many thanks and cheers from germany.
>>
>>Gerrit
>>    
>>
>
>  
>
>>Hello Linus,
>>
>>
>>Can you tell me where this magic address 0x78 in arch/i386/bootsect.S
>>refers to? I mean, is this somewhere specified?
>>
>>    
>>
>
>Hope you'll settle for an answer from a simple lkml lurker and not the top
>gun.
>
>The address 0x78 points to the floppy disk drive parameter table
>described here:  http://www.xs4all.nl/~matrix/fdd_pt.html
>
>A list of all the low memory ROM BIOS vectors and addresses can be
>found here:  http://www.cybertrails.com/~fys/rombios.htm
>
>Cheers,
>Sean
>
>
>  
>



