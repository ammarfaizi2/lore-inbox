Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbUKIAz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbUKIAz6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 19:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUKIAz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 19:55:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:9653 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261322AbUKIAvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 19:51:42 -0500
Date: Mon, 8 Nov 2004 16:49:38 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: phil@netroedge.com, sensors@stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i2c/busses/ : make some code static
Message-ID: <20041109004938.GC25651@kroah.com>
References: <20041107023333.GB14308@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041107023333.GB14308@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2004 at 03:33:33AM +0100, Adrian Bunk wrote:
> The patch below makes some needlessly global code under i2c/busses/ 
> static.
> 
> 
> diffstat output:
>  drivers/i2c/busses/i2c-ali1535.c |    4 ++--
>  drivers/i2c/busses/i2c-amd8111.c |   12 ++++++------
>  drivers/i2c/busses/scx200_acb.c  |    4 ++--
>  drivers/i2c/busses/scx200_i2c.c  |    4 ++--
>  4 files changed, 12 insertions(+), 12 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

greg k-h

