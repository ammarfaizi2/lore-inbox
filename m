Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUFNR6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUFNR6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 13:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUFNR6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 13:58:36 -0400
Received: from mail.kroah.org ([65.200.24.183]:13778 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263713AbUFNR6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 13:58:32 -0400
Date: Mon, 14 Jun 2004 10:57:05 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Fix PME bits in pci.txt
Message-ID: <20040614175705.GA27216@kroah.com>
References: <20040614172137.GA22012@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614172137.GA22012@k3.hellgate.ch>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 07:21:37PM +0200, Roger Luethi wrote:
> Signed-off-by: Roger Luethi <rl@hellgate.ch>
> 
> --- linux-2.6.7-rc3-bk6/Documentation/power/pci.txt.orig	2004-06-14 18:54:24.793573267 +0200
> +++ linux-2.6.7-rc3-bk6/Documentation/power/pci.txt	2004-06-14 18:54:40.962133902 +0200
> @@ -286,11 +286,11 @@
>  +------------------+
>  |  Bit  |  State   |
>  +------------------+
> -|  15   |   D0     |
> -|  14   |   D1     |
> +|  11   |   D0     |
> +|  12   |   D1     |
>  |  13   |   D2     |
> -|  12   |   D3hot  |
> -|  11   |   D3cold |
> +|  14   |   D3hot  |
> +|  15   |   D3cold |
>  +------------------+

Good catch, applied, thanks.

greg k-h
