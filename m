Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWCJBjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWCJBjl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWCJBjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:39:41 -0500
Received: from [69.90.147.196] ([69.90.147.196]:5769 "EHLO mail.kenati.com")
	by vger.kernel.org with ESMTP id S1750809AbWCJBjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:39:40 -0500
Message-ID: <4410D9F0.6010707@kenati.com>
Date: Thu, 09 Mar 2006 17:44:16 -0800
From: Carlos Munoz <carlos@kenati.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How can I link the kernel with libgcc ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm writing an audio driver and the hardware requires floating point 
arithmetic.  When I build the kernel I get the following errors at link 
time:

*** Warning: "__subdf3" [sound/sh/siu_sh7343.ko] undefined!
*** Warning: "__muldf3" [sound/sh/siu_sh7343.ko] undefined!
*** Warning: "__divdf3" [sound/sh/siu_sh7343.ko] undefined!
*** Warning: "__adddf3" [sound/sh/siu_sh7343.ko] undefined!

These symbols are coming from gcc. What I would like to do is link the 
kernel with libgcc to solve this errors. I'm looking at the kernel 
makefiles and it doesn't seem obvious to me how to do it. Does anyone 
know how I can link the kernel with libgcc, or point me in the right 
direction ?

By the way this is for the Renesas SH7343 processor.

Thanks,


Carlos Munoz
