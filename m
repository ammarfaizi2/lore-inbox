Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269454AbRHGVDa>; Tue, 7 Aug 2001 17:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269438AbRHGVDU>; Tue, 7 Aug 2001 17:03:20 -0400
Received: from cardinal0.Stanford.EDU ([171.64.15.238]:30376 "EHLO
	cardinal0.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S269435AbRHGVDK>; Tue, 7 Aug 2001 17:03:10 -0400
Date: Tue, 7 Aug 2001 14:02:46 -0700 (PDT)
From: Ted Unangst <tedu@stanford.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Igmar Palsenberg <maillist@jdimedia.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x VM problems thread
In-Reply-To: <fa.kga80kv.1fk0mqv@ifi.uio.no>
Message-ID: <Pine.GSO.4.31.0108071401180.5066-100000@cardinal0.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, Richard B. Johnson wrote:

> Wow a memory-mapped fork bomb! Now what on earth did you expect?
> Run it from a user-account with ulimits enabled for slightly less
> than the total system resources. Then complain.

not even mmap'ed.

case 0: break;
                                tmp = mmap(0, 64 * 4096, PROT_EXEC,
MAP_SHARED
| MAP_ANONYMOUS, -1, 0);

the mmap never even gets run.  might as well be for(;;) fork();




>
>
> Cheers,
> Dick Johnson
>
> Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
>
>     I was going to compile a list of innovations that could be
>     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>     was handled in the BIOS, I found that there aren't any.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--
"I am clearly more popular than Reagan.  I am in my third term.
Where's Reagan?  Gone after two!  Defeated by George Bush and
Michael Dukakis no less."
      - M. Barry, Mayor of Washington, DC

