Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbUKDTMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbUKDTMC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbUKDTJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:09:00 -0500
Received: from fire.osdl.org ([65.172.181.4]:37769 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262360AbUKDTIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:08:04 -0500
Message-ID: <418A7B71.1070307@osdl.org>
Date: Thu, 04 Nov 2004 10:56:49 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: yiding_wang@agilent.com
CC: linux-kernel@vger.kernel.org, Yidng_wang@agilent.com
Subject: Re: QM_MODULES not implemented in 2.6.9
References: <08A354A3A9CCA24F9EE9BE13600CFBC50F3AE3@wcosmb07.cos.agilent.com>
In-Reply-To: <08A354A3A9CCA24F9EE9BE13600CFBC50F3AE3@wcosmb07.cos.agilent.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yiding_wang@agilent.com wrote:
> I noticed that this issue was there before but thought it was being taken care of since my Linux-2.6.2 kernel did not complain. Now I loaded Linux-2.6.9 and this QM_MODULES Function not implemented error pops up whenever I run module related command.
> 
> If I need update module patch, could someone tell which module patch I should apply? If something else is wrong, please advice. The kernel is configured to support module.

You need to use module-init-tools that are made for 2.6.x kernels.
They can be found here:
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
and are often already part of most current Linux distros.

-- 
~Randy
