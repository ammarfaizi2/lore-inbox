Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVFAJbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVFAJbV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 05:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVFAJbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 05:31:21 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:10486 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261352AbVFAJah
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 05:30:37 -0400
Message-ID: <429D8046.3010403@tiscali.de>
Date: Wed, 01 Jun 2005 11:30:46 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gregor Jasny <gjasny@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Cyrix 6x86L does not get identified by Linux 2.6
References: <200506010036.27957.gjasny@web.de>
In-Reply-To: <200506010036.27957.gjasny@web.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregor Jasny wrote:
> Hi,
> 
> on my Cyrix 6x86L (notice the L) I've got the problem that it doesn't get 
> identified as a Cyrix processor. Instead it is treated as a common 486.
> 
> I think the problem is that the cpuid feature is not enabled after booting. So 
> init_cyrix which enables the cpuid feature is never called.
> 
> As a bad hack I've set the this_cpu pointer to cyrix in 
> common.c:identify_cpu():
> 
> this_cpu = cpu_devs[X86_VENDOR_CYRIX];
> 
> Who is responsible for x86 CPU detection?
Hans Peter Arvin? Andrew Balsa?
> [ ... ]
Matthias-Christian Ott
