Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSHDNZP>; Sun, 4 Aug 2002 09:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSHDNZP>; Sun, 4 Aug 2002 09:25:15 -0400
Received: from mail.hometree.net ([212.34.181.120]:50655 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S315265AbSHDNZO>; Sun, 4 Aug 2002 09:25:14 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: No Subject
Date: Sun, 4 Aug 2002 13:28:46 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <aija6e$brm$1@forge.intermeta.de>
References: <1028417880.1760.52.camel@irongate.swansea.linux.org.uk> <Pine.SOL.4.30.0208040049140.696-100000@mion.elka.pw.edu.pl>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1028467726 23134 212.34.181.4 (4 Aug 2002 13:28:46 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sun, 4 Aug 2002 13:28:46 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> writes:

>On 4 Aug 2002, Alan Cox wrote:

>> On Sat, 2002-08-03 at 23:16, Bartlomiej Zolnierkiewicz wrote:
>> > Just rethough it. What if chipset is in compatibility mode?
>> > Like VIA with base addresses set to 0?
>>
>> If we found a register that was marked as unassigned with a size then we
>> would map it to a PCI address. That would go for BAR0-3 on any PCI IDE
>> device attached to the south bridge.
>>
>> What problems does that cause for the VIA stuff ?

>In compatibility mode IDE chipsets have IO at legacy ISA ports and
>PCI_BASE_ADDRESS0-3 are set to them or to zero (at least on VIA).
>And they can't be programmed to any other ports (unless native mode).

Hi,

this sounds like a problem that I have with the ServerWorks OSB5
chipset. I actually have PCI_BASE_ADDRESS0-3 at 0 and
PCI_BASE_ADDRESS4 = 0x3a0.

Does this hold true here, too? Or is this VIA specific?

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
