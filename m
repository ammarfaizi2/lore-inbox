Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262953AbUJ1KjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbUJ1KjP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 06:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbUJ1Khd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 06:37:33 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:30220 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262956AbUJ1Kfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 06:35:53 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Re: Swap strangeness: total VIRT ~23mb for all processes, swap 91156k used - impossible?
Date: Thu, 28 Oct 2004 13:35:42 +0300
User-Agent: KMail/1.5.4
Cc: uclibc@uclibc.org
References: <200410281333.53976.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410281333.53976.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410281335.42197.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 13:33, Denis Vlasenko wrote:
> top output
> (note: some of them are busybox'ed, others are compiled
> against uclibc, some are statically built with dietlibc,
> rest is plain old shared binaries built against glibc):
> 
> top - 13:19:32 up 48 min,  1 user,  load average: 0.25, 0.22, 0.09
> Tasks:  80 total,   1 running,  79 sleeping,   0 stopped,   0 zombie
> Cpu(s):  0.2% us,  0.3% sy,  0.0% ni, 98.7% id,  0.8% wa,  0.0% hi,  0.0% si
> Mem:    112376k total,   109620k used,     2756k free,     6460k buffers
> Swap:   262136k total,    91156k used,   170980k free,     4700k cached

Forgot to post /proc/meminfo:

MemTotal:       112376 kB
MemFree:          3116 kB
Buffers:          6672 kB
Cached:           5104 kB
SwapCached:      88340 kB
Active:           7964 kB
Inactive:        92720 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       112376 kB
LowFree:          3116 kB
SwapTotal:      262136 kB
SwapFree:       172240 kB
Dirty:               8 kB
Writeback:           0 kB
Mapped:           5192 kB
Slab:             5284 kB
Committed_AS:     6020 kB
PageTables:        648 kB
VmallocTotal:   917476 kB
VmallocUsed:      2048 kB
VmallocChunk:   915384 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB
--
vda

