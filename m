Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbUKQA3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUKQA3D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 19:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbUKQA1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 19:27:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:33939 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262126AbUKQAZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 19:25:50 -0500
Message-ID: <419A978C.2010102@osdl.org>
Date: Tue, 16 Nov 2004 16:13:00 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: akpm <akpm@osdl.org>, ak@suse.de, lkml <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [PATCH] PCI: fix build errors with CONFIG_PCI=n
References: <419A8088.3010205@osdl.org> <20041116232600.GB2868@pclin040.win.tue.nl> <419A8EFE.8060508@osdl.org> <20041117001650.GC2868@pclin040.win.tue.nl>
In-Reply-To: <20041117001650.GC2868@pclin040.win.tue.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Tue, Nov 16, 2004 at 03:36:30PM -0800, Randy.Dunlap wrote:
> 
> 
>>> static int __init parport_init_mode_setup(char *str) {
>>
>>Yes, I'm familiar with that, but I made a patch against current
>>top of tree.
> 
> 
> I don't understand. Will you send another patch to fix the prototype?

Sorry, I did that yesterday:
http://lkml.org/lkml/2004/11/15/133

It didn't show up in today's patch because Andrew's "the
perfect patch" says:
(http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt)

b) Make sure that your patches apply to the latest version of the
    kernel tree.  Either straight from bitkeeper or from
    ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/

-- 
~Randy
