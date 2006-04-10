Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWDJOpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWDJOpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 10:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWDJOpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 10:45:40 -0400
Received: from [212.33.188.179] ([212.33.188.179]:37380 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751194AbWDJOpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 10:45:38 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Mon, 10 Apr 2006 17:43:17 +0300
User-Agent: KMail/1.5
Cc: Mike Galbraith <efault@gmx.de>, bert hubert <bert.hubert@netherlabs.nl>
References: <200604091944.28954.a1426z@gawab.com> <1144607596.7408.34.camel@homer>
In-Reply-To: <1144607596.7408.34.camel@homer>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604101743.17518.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:
> In general, Linux systems are not maxed out as they will disappoint that
> way (like any system running with id=0).

top - 16:59:23 up 29 min,  0 users,  load average: 993.49, 796.33, 496.21
Tasks: 1039 total, 1000 running,  39 sleeping,   0 stopped,   0 zombie
Cpu(s):  47.6% user,  52.4% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    125796k total,   123344k used,     2452k free,       64k buffers
Swap:  1020088k total,     9176k used,  1010912k free,     1752k cached

  PID  PR  NI  VIRT  RES  SHR SWAP S %CPU    TIME+  Command
 3946  28   0  2404 1460  720  944 R  5.8   0:14.78 top
 4219  37   0  1580  488  416 1092 R  3.0   0:00.45 ping
 4214  37   0  1584  480  408 1104 R  2.8   0:00.46 ping
 4196  37   0  1580  480  408 1100 R  2.5   0:00.45 ping
 4175  37   0  1584  488  416 1096 R  2.3   0:00.30 ping
 3950  37   1  1580  492  416 1088 R  2.0   0:08.77 ping
 4136  37   0  1580  488  416 1092 R  2.0   0:00.36 ping
 4158  37   0  1584  484  408 1100 R  2.0   0:00.35 ping
 4177  37   0  1580  480  408 1100 R  2.0   0:00.27 ping
 4180  37   0  1580  484  408 1096 R  2.0   0:00.33 ping
 4194  37   0  1580  480  408 1100 R  2.0   0:00.40 ping
 4199  37   0  1584  484  408 1100 R  2.0   0:00.47 ping
 4189  37   0  1580  488  416 1092 R  1.8   0:00.43 ping
 4153  37   0  1584  480  408 1104 R  1.5   0:00.31 ping
 4170  37   0  1584  484  408 1100 R  1.5   0:00.30 ping
 4191  37   0  1584  492  416 1092 R  1.5   0:00.41 ping
 4209  37   0  1584  484  408 1100 R  1.5   0:00.39 ping
 4215  37   0  1584  484  408 1100 R  1.5   0:00.39 ping
 4221  37   0  1580  492  416 1088 R  1.5   0:00.37 ping
 4146  37   0  1580  488  416 1092 R  1.3   0:00.29 ping
 4156  37   0  1584  484  408 1100 R  1.3   0:00.32 ping
 4166  37   0  1584  488  416 1096 R  1.3   0:00.33 ping
 4183  37   0  1580  480  408 1100 R  1.3   0:00.37 ping
 4216  37   0  1584  480  408 1104 R  1.3   0:00.39 ping
 4229  37   0  1584  484  408 1100 R  1.3   0:00.41 ping
 4233  37   0  1584  488  416 1096 R  1.3   0:00.41 ping
 4137  37   0  1580  484  408 1096 R  1.0   0:00.33 ping
 4141  37   0  1584  484  408 1100 R  1.0   0:00.31 ping
 4150  37   0  1580  484  408 1096 R  1.0   0:00.30 ping
 4161  37   0  1580  480  408 1100 R  1.0   0:00.29 ping
 4172  37   0  1584  484  408 1100 R  1.0   0:00.28 ping
 4178  37   0  1580  480  408 1100 R  1.0   0:00.25 ping
 4182  37   0  1584  484  408 1100 R  1.0   0:00.23 ping

After that the loadavg starts to wrap.
And even then it is possible to login.
And that's not with the default 2.6 scheduler, but rather w/ spa.

Thanks!

--
Al



