Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTGGIpn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 04:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264667AbTGGIpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 04:45:43 -0400
Received: from ns.suse.de ([213.95.15.193]:42767 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263945AbTGGIpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 04:45:42 -0400
Date: Mon, 7 Jul 2003 10:59:23 +0200
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.22-pre3] minor x86-64 boot-options.txt update
Message-Id: <20030707105923.4b61f6bd.ak@suse.de>
In-Reply-To: <200307062240.h66Met8h023829@harpo.it.uu.se>
References: <200307062240.h66Met8h023829@harpo.it.uu.se>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jul 2003 00:40:55 +0200 (MEST)
Mikael Pettersson <mikpe@csd.uu.se> wrote:


> --- linux-2.4.22-pre3/Documentation/x86_64/boot-options.txt.~1~	2003-07-06 18:37:42.000000000 +0200
> +++ linux-2.4.22-pre3/Documentation/x86_64/boot-options.txt	2003-07-06 19:21:06.000000000 +0200
> @@ -65,7 +65,8 @@
>    0 don't use an NMI watchdog
>    1 use the IO-APIC timer for the NMI watchdog
>    2 use the local APIC for the NMI watchdog using a performance counter. Note
> -  This will use one performance counter.
> +  This will use one performance counter and the local APIC's performance
> +  counter vector.

Thanks merged. 

BTW 1 does not seem to work, but I have not tracked it down yet. It would
be better to just default to 1.

-Andi

