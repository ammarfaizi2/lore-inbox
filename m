Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbTEESbZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 14:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbTEESbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 14:31:23 -0400
Received: from freeside.toyota.com ([63.87.74.7]:64417 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP id S261203AbTEESbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 14:31:19 -0400
Message-ID: <3EB6B0DD.2000404@tmsusa.com>
Date: Mon, 05 May 2003 11:43:41 -0700
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.69-mm1 OOPS: modprobe usbcore
References: <1052151088.1052.0.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:

>Process modprobe (pid: 62, threadinfo=df9f2000 task=dfdb8e00)
>
>
>[<c0118ab8>] module_finalize+0x7f/0x8b
>[<c013de18>] load_module+0x61c/0x821
>[<c013e0b1>] sys_init_module+0x94/0x340
>[<c0109e01>] sysenter_past_esp+0x52/0x71
>
>This error is reproducble 100% of the time when trying to boot Red Hat
>Linux 9 with a 2.5.69-mm1 kernel. Config attached.
>

Just a me too, I see the same thing in 2.5.69-mm1.

I first saw it in 2.5.68-mm4,  2.5.68-mm3 was fine -

I suspect 2.5.69 vanilla is fine as well, currently
compiling to verify -

Joe

