Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132575AbRDQG5B>; Tue, 17 Apr 2001 02:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132579AbRDQG4v>; Tue, 17 Apr 2001 02:56:51 -0400
Received: from tangens.hometree.net ([212.34.181.34]:34972 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S132575AbRDQG4p>; Tue, 17 Apr 2001 02:56:45 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@mail.hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: IP Acounting Idea for 2.5
Date: Tue, 17 Apr 2001 06:56:42 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9bgpfa$329$1@forge.intermeta.de>
In-Reply-To: <Pine.LNX.4.33.0104152039130.1616-100000@asdf.capslock.lan> <01041708461209.00352@workshop> <20010416020732.30431.qmail@logi.cc> <20010416224321.O16697@corellia.laforge.distro.conectiva>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 987490602 9518 212.34.181.4 (17 Apr 2001 06:56:42 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 17 Apr 2001 06:56:42 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte <laforge@gnumonks.org> writes:

>On Mon, Apr 16, 2001 at 12:07:31PM +1000, Manfred Bartz wrote:

>>                 *COUNTERS MUST NOT BE RESETABLE!!!*
>> 
>> Resetable counters guarantee that no two programs can co-exists if
>> they happen to reset the same counters.

>That sounds like crap (sorry). Counters are resettable, and will be.
>If you run two applications resetting counters individually, you have
>a problem with your applications.

Resettable counters in a security sensitive environment are just a
call for trouble. That's why you can't reset the SNMP counters on any
Cisco device I've encountered today. They learned their lesson. Maybe
you will, too.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
