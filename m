Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbULPPBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbULPPBc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 10:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbULPPBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 10:01:31 -0500
Received: from [195.23.16.24] ([195.23.16.24]:53395 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262689AbULPPAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 10:00:44 -0500
Message-ID: <41C1A31A.5070902@grupopie.com>
Date: Thu, 16 Dec 2004 15:00:42 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Park Lee <parklee_sel@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's the matter with build-in netconsole?
References: <20041216143537.41770.qmail@web51502.mail.yahoo.com>
In-Reply-To: <20041216143537.41770.qmail@web51502.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.29.0.5; VDF: 6.29.0.18; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Park Lee wrote:
> [...]
>   But then, when the system is booting, it shows the
> following message:
> 
> ... ...
> Uncompressing Linux... Ok, booting the kernel.
> audit(1103234064.4294965842:0): initialized
> netconsole: eth0 doesn't exist, aborting.
> ... ...

Just a shot in the dark here... maybe your compiling your network driver 
as a module and netconsole can not use it because it is not loaded soon 
enough.

If this is the case you should compile your network driver builtin.

-- 
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu

