Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268695AbTGIWpE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 18:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268697AbTGIWpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 18:45:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47494 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268695AbTGIWoi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 18:44:38 -0400
Message-ID: <3F0C9E3A.9080800@pobox.com>
Date: Wed, 09 Jul 2003 18:59:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: h.t.d@gmx.de
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ICH5 SATA controller not working in enhanced mode using
 SMP (2.4.21-ac4)
References: <5849.1057779997@www42.gmx.net>
In-Reply-To: <5849.1057779997@www42.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

h.t.d@gmx.de wrote:
> When I am booting with kernel-2.4.21-ac4-smp the system hangs. Here are the 
> last three lines of output: 
[...]
> When I am booting 2.4.21-ac4 in uniprocessor mode output looks like: 
[...]
> Conclusion: I think the problem is related to SMP and my chipset somehow, if


It sounds like an SMP-related bug in my libata driver.  I very much 
doubt it is a chipset problem.  I'll take a look this weekend, I have 
the hardware to reproduce.

Bug me if you don't hear anything after a couple days.

Thanks much for the report,

	Jeff



