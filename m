Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWFGXOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWFGXOL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 19:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWFGXOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 19:14:11 -0400
Received: from dvhart.com ([64.146.134.43]:32663 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932462AbWFGXOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 19:14:10 -0400
Message-ID: <44875DC0.2000406@mbligh.org>
Date: Wed, 07 Jun 2006 16:14:08 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.17-rc6-mm1
References: <20060607104724.c5d3d730.akpm@osdl.org>
In-Reply-To: <20060607104724.c5d3d730.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/



Build failures on everything but x86_64 (possibly different distro
or something)

   GEN     usr/klibc/syscalls/SYSCALLS.i
/usr/local/autobench/var/tmp/build/usr/klibc/SYSCALLS.def:30:26: missing 
terminating ' character
make[3]: *** [usr/klibc/syscalls/SYSCALLS.i] Error 1
make[2]: *** [usr/klibc/syscalls] Error 2
make[1]: *** [_usr_klibc] Error 2
make: *** [usr] Error 2
06/07/06-18:23:44 Build the kernel. Failed rc = 2
06/07/06-18:23:44 build: kernel build Failed rc = 1
06/07/06-18:23:44 command complete: (2) rc=126
Failed and terminated the run
  Fatal error, aborting autorun

Full example here:
	http://test.kernel.org/abat/35106/debug/test.log.0
