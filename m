Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbULZUbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbULZUbQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 15:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbULZUbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 15:31:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8128 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261160AbULZUbA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 15:31:00 -0500
Date: Sun, 26 Dec 2004 16:02:28 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: James Nelson <james4765@verizon.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] cyclades: Put README.cycladeZ in Documentation/serial
Message-ID: <20041226180228.GB17259@logos.cnet>
References: <20041226135306.11762.53625.55036@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041226135306.11762.53625.55036@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James,

Documentation/serial/ sounds fine to me, but the patch moves the file
to Documentation/ ?
 
On Sun, Dec 26, 2004 at 07:52:46AM -0600, James Nelson wrote:
> Put README.cycladesZ in Documentation/serial.
> 
> Firmware is still needed, but the README file shouldn't be in drivers/char.
> 
> Signed-off-by: James Nelson <james4765@gmail.com>
> 
> diff -urN --exclude='*~' linux-2.6.10-original/Documentation/README.cycladesZ linux-2.6.10/Documentation/README.cycladesZ
> --- linux-2.6.10-original/Documentation/README.cycladesZ	1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.10/Documentation/README.cycladesZ	2004-12-24 16:34:58.000000000 -0500
> @@ -0,0 +1,8 @@
> +
> +The Cyclades-Z must have firmware loaded onto the card before it will
> +operate.  This operation should be performed during system startup,
> +
> +The firmware, loader program and the latest device driver code are
> +available from Cyclades at
> +    ftp://ftp.cyclades.com/pub/cyclades/cyclades-z/linux/
> +
> diff -urN --exclude='*~' linux-2.6.10-original/drivers/char/README.cycladesZ linux-2.6.10/drivers/char/README.cycladesZ
> --- linux-2.6.10-original/drivers/char/README.cycladesZ	2004-12-24 16:34:58.000000000 -0500
> +++ linux-2.6.10/drivers/char/README.cycladesZ	1969-12-31 19:00:00.000000000 -0500
> @@ -1,8 +0,0 @@
> -
> -The Cyclades-Z must have firmware loaded onto the card before it will
> -operate.  This operation should be performed during system startup,
> -
> -The firmware, loader program and the latest device driver code are
> -available from Cyclades at
> -    ftp://ftp.cyclades.com/pub/cyclades/cyclades-z/linux/
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
