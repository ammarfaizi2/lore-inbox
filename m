Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312526AbSEUKOI>; Tue, 21 May 2002 06:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSEUKOH>; Tue, 21 May 2002 06:14:07 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:37644 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S312526AbSEUKOG>;
	Tue, 21 May 2002 06:14:06 -0400
Message-ID: <3CEA1DE8.6080201@gmx.at>
Date: Tue, 21 May 2002 12:14:00 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:0.9.9) Gecko/20020412 Debian/0.9.9-6
X-Accept-Language: en, de-at, de
MIME-Version: 1.0
To: alex-n@ua.fm
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG?
In-Reply-To: <web-10136453@ua.fm>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alex-n@ua.fm wrote:
> Dear Sirs,
> this can be lamer's question (I'm sorry rite now!), but...
> 
> The report itself is:
> 
> ################################################################################
> 
> [1.] Linux crashes at the 'interactive startup' boot stage.
> 
> [2.] Once the system is trying to boot, first stage (which is
>      *before* msg 'Interactive startup') it is all O.K. Once the
>      'Interactive startup' stage begins, the bootstrap process
>      fails with diffirent msgs; all of them begins with "Unable
>      to handle kernel paging request at address..." or "Unable
>      to handle kernel dereference at address..." (first 'reason'
>      is in the majority of cases, the second is quite unusual).
> 
>      It seems to me that this is a trouble with initrd.img,
>      because once I've recompiled kernel with ALL OPTIONS (not
>      suitable to my hardware, i.e. SCSI adapters) turned OFF,
>      the problem remains.
[snip]

2.4.7 does not have some VIA chipset workarounds that caused oopses when 
the kernel was compiled with K7 optimization. So set the optimization to 
AMD K6 or use a more recent kernel version. I think 2.4.16 and later 
versions have fixed this problem.

hope this helps,
Wilfried

