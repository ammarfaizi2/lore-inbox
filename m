Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVGGLz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVGGLz6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 07:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVGGLxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:53:44 -0400
Received: from [195.23.16.24] ([195.23.16.24]:6070 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261227AbVGGLwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:52:20 -0400
Message-ID: <42CD1752.9000406@grupopie.com>
Date: Thu, 07 Jul 2005 12:51:46 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexis Ballier <alexis.ballier@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc2 - Inconsistent kallsyms data
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org>	 <42CB8088.1090508@ppp0.net>	 <ea6b190205070602091b50e204@mail.gmail.com>	 <42CBE05F.4090706@grupopie.com> <ea6b1902050706075248674f97@mail.gmail.com>
In-Reply-To: <ea6b1902050706075248674f97@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexis Ballier wrote:
> Yes, that fixed it.

Ok, it is probably the same problem, then.

> However, there was no problem with rc1 with the
> same .config.

That's just the nature of it. It only triggers if you're unlucky. For 
more details check these threads:

http://lkml.org/lkml/2005/5/10/70

http://seclists.org/lists/linux-kernel/2005/May/2010.html

The fix in mm is actually very different from any proposed solution in 
those threads. For more details check here:

http://lkml.org/lkml/2005/6/27/188

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
