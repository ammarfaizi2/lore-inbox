Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131770AbRACNLm>; Wed, 3 Jan 2001 08:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131761AbRACNLW>; Wed, 3 Jan 2001 08:11:22 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:29395 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S131524AbRACNLO>; Wed, 3 Jan 2001 08:11:14 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@fi.muni.cz>
Subject: Re: Chipsets, DVD-RAM, and timeouts....
Message-ID: <3A531DC5.49F5EFC3@fi.muni.cz>
Date: Wed, 3 Jan 2001 12:40:37 GMT
To: David Woodhouse <dwmw2@infradead.org>
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: Czech, en
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <12542.978456659@redhat.com>
Mime-Version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre3 i686)
Organization: unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> The IBM DTLA drives aren't in the hpt366 bad_ata66_4 list still.

I'm using this drive with my BP6 without any problems.

But to have stable system I would suggest to not use UDMA4 mode
if you are stressing you harddrive to much.

Use UDMA3 (hdparm -X67 /dev/hd_your_ibm_drive)

With this mode I've been unable to crash my BP6 with any load on my
system)
Also try to use latest BIOSes (RU)

-- 
             There are three types of people in the world:
               those who can count, and those who can't.
  Zdenek Kabelac  http://i.am/kabi/ kabi@i.am {debian.org; fi.muni.cz}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
