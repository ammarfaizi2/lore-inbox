Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266171AbRF2UOt>; Fri, 29 Jun 2001 16:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266172AbRF2UOj>; Fri, 29 Jun 2001 16:14:39 -0400
Received: from h24-76-51-210.vf.shawcable.net ([24.76.51.210]:16885 "EHLO
	whiskey.enposte.net") by vger.kernel.org with ESMTP
	id <S266171AbRF2UOZ>; Fri, 29 Jun 2001 16:14:25 -0400
To: linux-kernel@vger.kernel.org
Path: whiskey.fireplug.net!not-for-mail
From: sl@whiskey.fireplug.net (Stuart Lynne)
Newsgroups: list.linux-kernel
Subject: Re: Cosmetic JFFS patch.
Date: 29 Jun 2001 13:13:24 -0700
Organization: fireplug
Distribution: local
Message-ID: <9hinh4$47a$1@whiskey.enposte.net>
In-Reply-To: <993825330.30635@whiskey.enposte.net>
Reply-To: sl@fireplug.net
X-Newsreader: trn 4.0-test67 (15 July 1998)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <993825330.30635@whiskey.enposte.net>,
Chuck Wolber <chuckw@altaserv.net> wrote:
>> Does sed tell you who programmed it on startup?
>>
>> Awk?
>>
>> Perl?
>>
>> Groff?
>>
>> Gcc?
>>
>> See a pattern here?
>
>Yeah, the output of these programms are usually parsed by other programs.
>If they barked version info, that'd be extra code that has to go into
>*EVERY* script that uses them. You're not using the kernel in the same
>capacity.

A counter example that does both, bc does tell us who wrote it 
every time we run it (most annoying) and is smart enough to know
when it is not talking to a tty.

    % bc
    bc 1.05
    Copyright 1991, 1992, 1993, 1994, 1997, 1998 Free Software Foundation, Inc.
    This is free software with ABSOLUTELY NO WARRANTY.
    For details type `warranty'. 
    1+2
    3
    % bc > test
    1+2
    % cat test
    3
    %

I think listing driver versions on boot with perhaps some diagnostic info
if appropriate is useful. Names and copyrights should be in the source.

-- 
                                            __O 
Lineo - For Embedded Linux Solutions      _-\<,_ 
PGP Fingerprint: 28 E2 A0 15 99 62 9A 00 (_)/ (_) 88 EC A3 EE 2D 1C 15 68
Stuart Lynne <sl@fireplug.net>       www.fireplug.net        604-461-7532
