Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270619AbRH1KG6>; Tue, 28 Aug 2001 06:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270624AbRH1KGh>; Tue, 28 Aug 2001 06:06:37 -0400
Received: from gate.terreactive.ch ([212.90.202.121]:38393 "HELO
	toe.terreactive.ch") by vger.kernel.org with SMTP
	id <S270619AbRH1KGg>; Tue, 28 Aug 2001 06:06:36 -0400
Message-ID: <3B8B6CEF.17C616C0@tac.ch>
Date: Tue, 28 Aug 2001 12:05:35 +0200
From: Roberto Nibali <ratz@tac.ch>
Organization: terreActive
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en, de-CH, zh-CN
MIME-Version: 1.0
To: Andrew Theurer <habanero@us.ibm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Journal Filesystem Comparison on Netbench
In-Reply-To: <3B8A6122.3C784F2D@us.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thank you for those interesting tests.

> Some optimizations were used for linux, including zerocopy,
> IRQ affinity, and interrupt delay for the gigabit cards,
> and process affinity for the smbd processes.

Why is ext3 the only tested journaling filesystem that showed
dropped packets [1] during the test and how do you explain it?

[1]: http://lse.sourceforge.net/benchmarks/netbench/results/\
     august_2001/filesystems/raid1e/ext3/4p/droppped_packets.txt

Regards,
Roberto Nibali, ratz

-- 
mailto: `echo NrOatSz@tPacA.cMh | sed 's/[NOSPAM]//g'`
