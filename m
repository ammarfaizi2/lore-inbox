Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268218AbUGXBdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268218AbUGXBdd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 21:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268219AbUGXBdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 21:33:33 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:51078 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268218AbUGXBdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 21:33:31 -0400
Subject: Re: [ANNOUNCE] ketchup 0.8
From: Lee Revell <rlrevell@joe-job.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040723185504.GJ18675@waste.org>
References: <20040723185504.GJ18675@waste.org>
Content-Type: text/plain
Message-Id: <1090632808.1471.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 23 Jul 2004 21:33:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-23 at 14:55, Matt Mackall wrote:
> ketchup is a script that automatically patches between kernel
> versions, downloading and caching patches as needed, and automatically
> determining the latest versions of several trees. Available at:
> 
>  http://selenic.com/ketchup/ketchup-0.8
> 

Does not work on Debian unstable:

rlrevell@mindpipe:~/kernel-source$ ketchup-0.8 2.6-mm
Creating cache directory /home/rlrevell/.ketchup
None -> 2.6.8-rc1-mm1
Downloading linux-2.6.7.tar.bz2
--21:14:12--  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.7.tar.bz2
           => `/home/rlrevell/.ketchup/linux-2.6.7.tar.bz2.partial'
Resolving www.kernel.org... 204.152.189.116
Connecting to www.kernel.org[204.152.189.116]:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 35,092,228 [application/x-bzip2]

100%[====================================>] 35,092,228   187.32K/s    ETA 00:00

21:17:17 (185.54 KB/s) - `/home/rlrevell/.ketchup/linux-2.6.7.tar.bz2.partial' s
aved [35092228/35092228]

Traceback (most recent call last):
  File "/usr/local/bin/ketchup-0.8", line 551, in ?
    transform(a, b)
  File "/usr/local/bin/ketchup-0.8", line 475, in transform
    a = install_nearest(base(b))
  File "/usr/local/bin/ketchup-0.8", line 437, in install_nearest
    if not f:
UnboundLocalError: local variable 'f' referenced before assignment

Lee

