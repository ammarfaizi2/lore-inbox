Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313492AbSEMNz5>; Mon, 13 May 2002 09:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313529AbSEMNz5>; Mon, 13 May 2002 09:55:57 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:4259 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S313492AbSEMNz4>; Mon, 13 May 2002 09:55:56 -0400
From: "BALBIR SINGH" <balbir.singh@wipro.com>
To: "Rik van Riel" <riel@conectiva.com.br>,
        "Zlatko Calusic" <zlatko.calusic@iskon.hr>
Cc: "Bill Davidsen" <davidsen@tmr.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH] IO wait accounting
Date: Mon, 13 May 2002 17:10:17 +0530
Message-ID: <AAEGIMDAKGCBHLBAACGBCEDDCIAA.balbir.singh@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-aabc047e-6650-11d6-a942-00b0d0d06be8"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.44L.0205121812500.32261-100000@imladris.surriel.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-aabc047e-6650-11d6-a942-00b0d0d06be8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I found a URL that you might find useful.

http://sunsite.uakom.sk/sunworldonline/swol-08-1997/swol-08-insidesolaris.ht
ml

Simple and straight forward implementation of a per-cpu iowait statistics
counter.

Balbir

|-----Original Message-----
|From: linux-kernel-owner@vger.kernel.org
|[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Rik van Riel
|Sent: Monday, May 13, 2002 2:44 AM
|To: Zlatko Calusic
|Cc: Bill Davidsen; linux-mm@kvack.org; linux-kernel@vger.kernel.org
|Subject: Re: [RFC][PATCH] IO wait accounting
|
|
|On Sun, 12 May 2002, Zlatko Calusic wrote:
|> Rik van Riel <riel@conectiva.com.br> writes:
|> >
|> > And should we measure read() waits as well as page faults or
|> > just page faults ?
|>
|> Definitely both.
|
|OK, I'll look at a way to implement these stats so that
|every IO wait counts as iowait time ... preferably in a
|way that doesn't touch the code in too many places ;)
|
|> Somewhere on the web was a nice document explaining
|> how Solaris measures iowait%, I read it few years ago and it was a
|> great stuff (quite nice explanation).
|>
|> I'll try to find it, as it could be helpful.
|
|Please, it would be useful to get our info compatible with
|theirs so sysadmins can read their statistics the same on
|both systems.
|
|kind regards,
|
|Rik
|--
|Bravely reimplemented by the knights who say "NIH".
|
|http://www.surriel.com/		http://distro.conectiva.com/
|
|-
|To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
|the body of a message to majordomo@vger.kernel.org
|More majordomo info at  http://vger.kernel.org/majordomo-info.html
|Please read the FAQ at  http://www.tux.org/lkml/


------=_NextPartTM-000-aabc047e-6650-11d6-a942-00b0d0d06be8
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer************************************
      


Information contained in this E-MAIL being proprietary to Wipro Limited
is 'privileged' and 'confidential' and intended for use only by the
individual or entity to which it is addressed. You are notified that any
use, copying or dissemination of the information contained in the E-MAIL
in any manner whatsoever is strictly prohibited.



 ********************************************************************

------=_NextPartTM-000-aabc047e-6650-11d6-a942-00b0d0d06be8--
