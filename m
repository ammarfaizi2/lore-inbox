Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933088AbWKMWeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933088AbWKMWeo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 17:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933089AbWKMWeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 17:34:44 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:26613 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S933088AbWKMWeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 17:34:44 -0500
Date: Mon, 13 Nov 2006 14:34:39 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: <Greg.Chandler@wellsfargo.com>
Cc: <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>
Subject: Re: [PATCH 1/1] drivers/block/Kconfig text update.
Message-Id: <20061113143439.ef72428d.randy.dunlap@oracle.com>
In-Reply-To: <E8C008223DD5F64485DFBDF6D4B7F71D022358D6@msgswbmnmsp25.wellsfargo.com>
References: <E8C008223DD5F64485DFBDF6D4B7F71D022358D6@msgswbmnmsp25.wellsfargo.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006 16:24:22 -0600 Greg.Chandler@wellsfargo.com wrote:

> 
> The second line of the drivers/block/cciss.c file says:
> 
> " *    Disk Array driver for HP SA 5xxx and 6xxx Controllers"
> 
> I couldn't find the 6 series anywhere in the menu, and I ended up
> finding it in the code...

Please read/observe Documentation/SubmittingPatches:
the --- & +++ lines should begin with linux/drivers/... or a/drivers/...
so that the patch can be applied with "patch -p1".

> --- drivers/block/Kconfig.old   2006-11-13 14:20:12.000000000 -0800
> +++ drivers/block/Kconfig       2006-11-13 14:20:32.000000000 -0800
> @@ -155,10 +155,10 @@
>           this driver.
> 
>  config BLK_CPQ_CISS_DA
> -       tristate "Compaq Smart Array 5xxx support"
> +       tristate "Compaq Smart Array 5xxx/6xxx support"
>         depends on PCI
>         help
> -         This is the driver for Compaq Smart Array 5xxx controllers.
> +         This is the driver for Compaq Smart Array 5xxx/6xxx
> controllers.

Patch is line-wrapped on the line above.

>           Everyone using these boards should say Y here.
>           See <file:Documentation/cciss.txt> for the current list of
>           boards supported by this driver, and for further information

---
~Randy
