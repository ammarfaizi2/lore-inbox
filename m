Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWEOT1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWEOT1R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWEOT1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:27:17 -0400
Received: from stinky.trash.net ([213.144.137.162]:53707 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1750750AbWEOT1Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:27:16 -0400
Message-ID: <4468D613.20309@trash.net>
Date: Mon, 15 May 2006 21:27:15 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Ayres <matta@tektonic.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: Panic in ipt_do_table with 2.6.16.13-xen
References: <4468BE70.7030802@tektonic.net>
In-Reply-To: <4468BE70.7030802@tektonic.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Ayres wrote:
> I have been noticing this same problem dozens of times and have finally
> caught a full trace.  I have run it through ksymoops, but there is no
> /proc/ksyms.  Is there a better method for getting information out of
> the Code line than using ksymoops in 2.6 kernels?


CONFIG_KALLSYMS will make the kernel decode the oops itself.

> The kernel is for Xen, but it does not appear to be related to Xen.


We haven't had problems in that code for ages, so my initial feeling
is that it probably is related to Xen. Do you have any other patches
applied besides Xen? Please also post the full ruleset you're using
and anything else that might appear special about your setup.

