Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbUL2UHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbUL2UHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 15:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUL2UF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 15:05:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60306 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261416AbUL2UFn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 15:05:43 -0500
Date: Wed, 29 Dec 2004 15:23:53 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: James Nelson <james4765@verizon.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] cyclades: Put README.cycladeZ in Documentation/serial
Message-ID: <20041229172353.GB29821@logos.cnet>
References: <20041229104743.24177.82288.68966@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041229104743.24177.82288.68966@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ACK

added Signed-off-By line.

On Wed, Dec 29, 2004 at 04:47:22AM -0600, James Nelson wrote:
> Put README.cycladesZ in Documentation/serial.
> 
> Firmware is still needed, but the README file shouldn't be in drivers/char.
> 
> Signed-off-by: James Nelson <james4765@gmail.com>
> Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
> 
> diff -urN --exclude='*~' linux-2.6.10-original/Documentation/serial/README.cycladesZ linux-2.6.10/Documentation/serial/README.cycladesZ
> --- linux-2.6.10-original/Documentation/serial/README.cycladesZ	1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.10/Documentation/serial/README.cycladesZ	2004-12-24 16:34:58.000000000 -0500
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
