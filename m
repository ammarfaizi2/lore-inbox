Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264940AbTIJIUe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 04:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbTIJIUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 04:20:34 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:19908 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S264645AbTIJIUL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 04:20:11 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 10 Sep 2003 10:29:44 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video/hexium_orion warning removal
Message-ID: <20030910082944.GB15486@bytesex.org>
References: <20030909160245.49e8bddd.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030909160245.49e8bddd.shemminger@osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -Nru a/drivers/media/video/hexium_orion.h b/drivers/media/video/hexium_orion.h
> --- a/drivers/media/video/hexium_orion.h	Tue Sep  9 15:56:54 2003
> +++ b/drivers/media/video/hexium_orion.h	Tue Sep  9 15:56:54 2003
> @@ -30,109 +30,4 @@
>  /*30*/ 0x44,0x75,0x01,0x8C,0x03
>  };
>  
> -static struct {
> -	struct hexium_data data[8];	
> -} hexium_input_select[] = {
> -{
> -	{ /* input 1 */

I'd suggest to #if 0 that instead of deleting, it is probably there for
a reason, maybe just a not completed-yet part of the driver ...

  Gerd

