Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314049AbSD0DhQ>; Fri, 26 Apr 2002 23:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314565AbSD0DhP>; Fri, 26 Apr 2002 23:37:15 -0400
Received: from enchanter.real-time.com ([208.20.202.11]:40204 "EHLO
	enchanter.real-time.com") by vger.kernel.org with ESMTP
	id <S314049AbSD0DhP>; Fri, 26 Apr 2002 23:37:15 -0400
Date: Fri, 26 Apr 2002 22:37:09 -0500
From: Bob Tanner <tanner@real-time.com>
To: linux-kernel@vger.kernel.org
Subject: BIOS says MP, kernel says XP was PROBLEM: Dual (2) AMD ATHLON MP 1900+ CPUs gives APIC error on CPU[0]: 00(02)
Message-ID: <20020426223709.A3301@real-time.com>
Reply-To: tanner@real-time.com
In-Reply-To: <20020426213315.K25965@real-time.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-message-flag: Outlook has several security flaws. Please see http://cws.internet.com/mail.html for alternatives
X-MSMail-Priority: High
X-Priority: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bob Tanner (tanner@real-time.com):
> [1.] One line summary of the problem:    
> Dual (2) AMD ATHLON MP 1900+ CPUs gives APIC error on CPU[0]: 00(02)

<snip>

> CPU0 AMD ATHLONG (TM) MP 1900+
> CPU1 *AMD ATHLONG (TM) MP 1900+

<snip>

> CPU0 AMD ATHLON (TM) XP 1900+ stepping 02
> CPU1: AMD ATHLON (TM) XP 1900+ stepping 02

Thanks to Jerry McBride, I think the problem is this. 

The BIOS reports the CPUs as MP, but the kernel detects them as XP. As Jerry
pointed out you can't run dual XP processors.

I just grabbed the box the CPUs came in. It states the CPUs are MP.

How can I tell if the problem is with the BIOS, CPUs or kernel?

-- 
Bob Tanner <tanner@real-time.com>         | Phone : (952)943-8700
http://www.mn-linux.org, Minnesota, Linux | Fax   : (952)943-8500
Key fingerprint =  6C E9 51 4F D5 3E 4C 66 62 A9 10 E5 35 85 39 D9 

