Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313771AbSDHV6W>; Mon, 8 Apr 2002 17:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313772AbSDHV6V>; Mon, 8 Apr 2002 17:58:21 -0400
Received: from jalon.able.es ([212.97.163.2]:63957 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S313771AbSDHV6U>;
	Mon, 8 Apr 2002 17:58:20 -0400
Date: Mon, 8 Apr 2002 23:58:14 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "Kuppuswamy, Priyadarshini" <Priyadarshini.Kuppuswamy@compaq.com>,
        linux-kernel@vger.kernel.org
Subject: Re: system call for finding the number of cpus??
Message-ID: <20020408215814.GC13043@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.44.0204081456120.1498-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.04.08 Davide Libenzi wrote:
>On Mon, 8 Apr 2002, Kuppuswamy, Priyadarshini wrote:
>
>> Hi!
>>   I have a script that is using the /cpu/procinfo file to determine the
>> number of cpus present in the system. But I would like to implement it
>> using a system call rather than use the environment variables?? I
>> couldn't find a system call for linux that would give me the result.
>> Could anyone please let me know if there is one for redhat linux??
>
>sysconf(_SC_NPROCESSORS_CONF);
>

I din't really trusted you, so digged inside includes till bits/confname.h
Why the h*ll the manpage about sysconf does not talk about that ?????



-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre6-jam1 #1 SMP Sun Apr 7 00:50:05 CEST 2002 i686
