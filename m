Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132421AbRDUBe6>; Fri, 20 Apr 2001 21:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132422AbRDUBei>; Fri, 20 Apr 2001 21:34:38 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.121.12]:10453 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S132421AbRDUBeb>; Fri, 20 Apr 2001 21:34:31 -0400
Message-ID: <0aa401c0ca03$333fdd70$1125a8c0@wednesday>
From: "J. Dow" <jdow@earthlink.net>
To: <lee@ricis.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <86256A34.0079A841.00@smtpnotes.altec.com> <01042101555600.03154@blackbox> <01042020185806.00845@linux>
Subject: Re: Current status of NTFS support
Date: Fri, 20 Apr 2001 18:34:24 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lee Leahu" <lee@ricis.com>

> would somebody be kind enough to explain why writing to 
> the ntfs file system is extremely dangerous,  and what are the
> developers doing to make writing to ntfs filesystem safe?

My understanding of the situation is that writing to an NTFS volume is not
quite 100% guaranteed to destroy the disk directory structure. MS mutates it
faster than people can reverse engineer it in a proper "clean" manner. The
person who had been working the issue had access to MS information in support
of some other products. MS came down on him about supporting NTFS. So he has
surrendered such materials as he has rather than continue with the MS product
support and is concentrating on Linux. But until his NDA runs out he cannot
work on the NTFS code. Other people have picked up the ball. But as noted
MS mutates NTFS remarkably rapidly so I'd not look for support for NTFS in
the near future.

I have oversimplified the whole issue for which I hope others forgive me. I
see no benefit to a rehash of the issue so I am attempting to inject enough
information that it will be dropped.

{^_^}    Joanne Dow, jdow@earthlink.net

