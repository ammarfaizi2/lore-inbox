Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271620AbRHUJDq>; Tue, 21 Aug 2001 05:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271619AbRHUJDh>; Tue, 21 Aug 2001 05:03:37 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:18195 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S271618AbRHUJDV>; Tue, 21 Aug 2001 05:03:21 -0400
Message-ID: <3B8223E2.48F7A586@namesys.com>
Date: Tue, 21 Aug 2001 13:03:30 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Corin Hartland-Swann <cdhs@commerce.uk.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: sync hanging
In-Reply-To: <Pine.LNX.4.21.0108210353520.11035-100000@willow.commerce.uk.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corin Hartland-Swann wrote:
> 
> Hi there,
> 
> I'm using kernel 2.4.8-ac2 on a Dual PIII-1000 with 4096M RAM, and a
> reiserfs filesystem on a RAID-1 mirror of two 76GB UDMA disks, and I'm
> experiencing a strange problem after the machine has been running for a
> while.
> 
> Every now and again, running sync(1) (i.e. the program) seems to hang and
> end up in state D (uninterruptible sleep). There is no way to kill it
> (even with SIGKILL but I assume that this is typical for state D
> processes.
> 
> Does anyone have any idea what may be causing this? I have searched the
> archives and couldn't find anything similar.
> 
> Thanks,
> 
> Corin
> 
> PS: Please CC any replies to me.
> 
> /------------------------+-------------------------------------\
> | Corin Hartland-Swann   |    Tel: +44 (0) 20 7491 2000        |
> | Commerce Internet Ltd  |    Fax: +44 (0) 20 7491 2010        |
> | 22 Cavendish Buildings | Mobile: +44 (0) 79 5854 0027        |
> | Gilbert Street         |                                     |
> | Mayfair                |    Web: http://www.commerce.uk.net/ |
> | London W1K 5HJ         | E-Mail: cdhs@commerce.uk.net        |
> \------------------------+-------------------------------------/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
turn off highmem, known bug, I don't know if it is solved yet.

Hans
