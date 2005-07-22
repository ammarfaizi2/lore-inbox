Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVGVM63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVGVM63 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 08:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVGVM61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 08:58:27 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:22329 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S261274AbVGVM5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 08:57:47 -0400
Date: Fri, 22 Jul 2005 14:57:46 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Ashley <ashleyz@alchip.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel cached memory
Message-ID: <20050722125746.GG20258@harddisk-recovery.com>
References: <003401c58ea2$4dfd76f0$5601010a@ashley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003401c58ea2$4dfd76f0$5601010a@ashley>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2005 at 05:46:58PM +0800, Ashley wrote:
>    I've a server with 2 Operton 64bit CPU and 12G memory, and this server 
> is used to run  applications which will comsume huge memory,
> the problem is: when this aplications exits,  the free memory of the server 
> is still very low(accroding to the output of "top"), and
> from the output of command "free", I can see that many GB memory was cached 
> by kernel. Does anyone know how to free the kernel cached
> memory? thanks in advance.

Free memory is bad, it means the memory doesn't have a proper use.
Cached memory will be freed automatically when the kernel needs memory
for other (more important) things.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
