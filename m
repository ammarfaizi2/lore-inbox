Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVCIXQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVCIXQr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVCIXQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:16:34 -0500
Received: from mail8.fw-sd.sony.com ([160.33.66.75]:9124 "EHLO
	mail8.fw-sd.sony.com") by vger.kernel.org with ESMTP
	id S262074AbVCIXIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:08:50 -0500
Message-ID: <422F81F5.3090109@am.sony.com>
Date: Wed, 09 Mar 2005 15:08:37 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tony Luck <tony.luck@intel.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add timing information to printk messages
References: <200503092136.j29La5E26081@unix-os.sc.intel.com>
In-Reply-To: <200503092136.j29La5E26081@unix-os.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Luck wrote:
>>Here's a little patch which is useful for showing timing information for
>>kernel bootup activities.
>>
>>This patch adds a new Kconfig option under "Kernel Hacking" and a new
>>option for the kernel command line.  It also provides a script for
>>showing delta information.
> 
> 
> I'm seeing some odd output with CONFIG_PRINTK_TIME=y during boot.  When
> it is set to "no", I see this from "dmesg":

Thanks very much for the bug report.  I had another report from Tom Zanussi
about possibly trying to print when at the end of the string.  I think
it may be related, but in any event I'll look into it right away.

I appreciate your reporting it!
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
