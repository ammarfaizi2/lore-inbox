Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265379AbUBARuo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 12:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUBARuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 12:50:44 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:19079 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S265379AbUBARun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 12:50:43 -0500
Date: Sun, 1 Feb 2004 18:48:29 +0100
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: Philip.Blundell@pobox.com, tim@cyberelk.net, campbell@torque.net,
       andrea@e-mind.com, linux-parport@torque.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PARPORT: C99 Initializers
Message-ID: <20040201174829.GA1277@mars>
References: <20040201.224431.17604798.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201.224431.17604798.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 10:44:31PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> Hello.
> 
> D: convert drivers/parport/procfs.c to C99 initializers.
> 
> ===== drivers/parport/procfs.c 1.2 vs edited =====
> --- 1.2/drivers/parport/procfs.c	Tue Feb  5 16:37:25 2002
> +++ edited/drivers/parport/procfs.c	Sun Feb  1 22:41:55 2004
> @@ -232,12 +232,29 @@
> +			.proc_handler	=	&do_autoprobe,
> +		},
> +		{i
> +		 ^	.ctl_name	=	DEV_PARPORT_AUTOPROBE + 1, 
> +		 |	.procname	=	"autoprobe0",
		 |

		 Oops :)
