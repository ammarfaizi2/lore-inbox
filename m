Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbTAWOo7>; Thu, 23 Jan 2003 09:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264962AbTAWOo7>; Thu, 23 Jan 2003 09:44:59 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:936 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S264939AbTAWOo6>;
	Thu, 23 Jan 2003 09:44:58 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: rubisko.ascs.muni.cz!xkaminsk
From: Zdenek SUTR Kaminski <xkaminsk@rubisko.ascs.muni.cz>
Subject: Re: 2.4.21pre3-ac4 ide trouble (HPT370 and IBM DTLA-30745)
Message-ID: <Pine.LNX.4.44.0301231550410.23594-100000@rubisko.ascs.muni.cz>
In-Reply-To: <20030123121527.GA29958@middle.of.nowhere>
Date: Thu, 23 Jan 2003 14:54:04 GMT
To: Jurriaan <thunder7@xs4all.nl>
X-Nntp-Posting-Host: rubisko.ascs.muni.cz
Reply-To: xkaminsk@fi.muni.cz
Content-Type: TEXT/PLAIN; charset=US-ASCII
References: <20030123121527.GA29958@middle.of.nowhere>
Mime-Version: 1.0
Organization: unknown
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> hde: IBM-DTLA-307045, ATA DISK drive


in drivers/ide/hpt366.c I see:

const char *bad_ata100_5[] = {
...
    "IBM-DTLA-307045",
...
}

I had a same problem and I solved it with other disk...



-- 
Bc. Zdenek Kaminski <xkaminsk at fi.muni.cz>

homepage: http://www.fi.muni.cz/~xkaminsk/
IPv6 router homepage: http://www.openrouter.net/
Key: 0xD7315488
Key fingerprint: 3CB0 8108 CB76 446E 2895 AF33 9B3A 851B D731 5488

